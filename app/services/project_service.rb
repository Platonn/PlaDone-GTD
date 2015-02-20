class ProjectService
  def initialize
    @project_log_service = ProjectLogService.new
  end

  def get_project_by_id(project_id, current_user)
    project = find_project_by_id(project_id)
    current_user.can_use?(project) ? project : nil
  end

  def get_active_projects_of(user)
    user.projects.active.order(:updated_at)
  end

  def create(project_form, creator_user)
    project_form.validate!
    project = creator_user.projects.build(project_form.attributes)
    creator_user.save!
    @project_log_service.project_created(project.id, creator_user.id, project.name)
    project
  end

  def update(project_id, project_form, current_user)
    project_form.validate!
    project = find_project_by_id(project_id)
    update_success = current_user.can_use?(project) ? project.update!(project_form.attributes) : nil
    updated_project = find_project_by_id(project_id)
    @project_log_service.project_updated(project.id, current_user.id, project, updated_project) if update_success
    update_success
  end

  def soft_delete(project_id, current_user)
    project = find_project_by_id(project_id)
    delete_success = current_user.can_use?(project) ? project.soft_delete : nil
    @project_log_service.project_deleted(project.id, current_user.id) if delete_success
    delete_success
  end

  private
  def find_project_by_id(project_id)
    project = Project.find(project_id)
  end
end