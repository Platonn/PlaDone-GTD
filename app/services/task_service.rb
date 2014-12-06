class TaskService
  def initialize(current_user)
    @current_user = current_user
  end

  def get_task_by_id(task_id)
    task = Task.find(task_id)
    current_user_can_use_task?(task) ? task : nil
  end

  def get_active_tasks_of_current_user
    get_active_tasks_of_user(@current_user)
  end

  def get_active_tasks_of_user(user)
    user.tasks.active.order(:done,
                            :context_id,
                            :deadline,
                            updated_at: :desc,
                            created_at: :desc)
  end

  def create(task_form, owner_user)
    task_form.validate!
    task = owner_user.tasks.build(task_form.attributes)
    current_user_can_use_task?(task) ? task.save : nil
  end

  def update(task, task_form)
    task_form.validate!
    current_user_can_use_task?(task) ? task.update(task_form.attributes) : nil
  end

  def soft_delete(task)
    current_user_can_use_task?(task) ? task.soft_delete : nil
  end

  def toggle_done(task)
    task.done != task.done
    current_user_can_use_task?(task) ? task.save : nil
  end

  private
    def current_user_can_use_task?(task)
      user_can_use_task?(@current_user, task)
    end

    def user_can_use_task?(user, task)
      user.has_role?(:admin) || user.owns?(task)
    end
end