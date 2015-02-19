class ProjectCategoryService
  def get_project_category_by_id(project_category_id, current_user)
    project_category = find_project_category_by_id(project_category_id)
    current_user.can_use?(project_category) ? project_category : nil
  end

  def get_active_project_categories_of(user)
    user.project_categories.active.order(:name)
  end

  def create(project_category_form, creator_user)
    project_category_form.validate!
    project_category = creator_user.project_categories.build(project_category_form.attributes)
    creator_user.save!
    return project_category
  end

  def update(project_category_id, project_category_form, current_user)
    project_category_form.validate!
    project_category = find_project_category_by_id(project_category_id)
    current_user.can_use?(project_category) ? project_category.update(project_category_form.attributes) : nil
  end

  def soft_delete(project_category_id, current_user)
    project_category = find_project_category_by_id(project_category_id)
    current_user.can_use?(project_category) ? project_category.soft_delete : nil
  end

  def toggle_done(project_category_id, current_user)
    project_category = find_project_category_by_id(project_category_id)
    project_category.done = !project_category.done
    current_user.can_use?(project_category) ? project_category.save : nil
  end

  private
  def find_project_category_by_id(project_category_id)
    project_category = ProjectCategory.find(project_category_id)
  end
end