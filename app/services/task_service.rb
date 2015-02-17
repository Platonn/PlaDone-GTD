class TaskService
  def get_task_by_id(task_id, current_user)
    task = find_task_by_id(task_id)
    current_user.can_use?(task) ? task : nil
  end

  def get_active_tasks_of(user)
    user.tasks.active.order(:done,
                            :context_id,
                            :deadline,
                            updated_at: :desc,
                            created_at: :desc)
  end

  def create(task_form, creator_user)
    task_form.validate!
    creator_user.tasks.build(task_form.attributes)
  end

  def update(task_id, task_form, current_user)
    task_form.validate!
    task = find_task_by_id(task_id)
    current_user.can_use?(task) ? task.update(task_form.attributes) : nil
  end

  def soft_delete(task_id, current_user)
    task = find_task_by_id(task_id)
    current_user.can_use?(task) ? task.soft_delete : nil
  end

  def toggle_done(task_id, current_user)
    task = find_task_by_id(task_id)
    task.done != task.done
    current_user.can_use?(task) ? task.save : nil
  end

private
  def find_task_by_id(task_id)
    task = Task.find(task_id)
  end
end