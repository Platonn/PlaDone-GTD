class ProjectService
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
    return project
  end

  def update(project_id, project_form, current_user)
    project_form.validate!
    project = find_project_by_id(project_id)
    current_user.can_use?(project) ? project.update(project_form.attributes) : nil
  end

  def soft_delete(project_id, current_user)
    project = find_project_by_id(project_id)
    current_user.can_use?(project) ? project.soft_delete : nil
  end

  private
  def find_project_by_id(project_id)
    project = Project.find(project_id)
  end
end