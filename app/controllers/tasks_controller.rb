class TasksController < ApplicationController
  #load_and_authorize_resource
  before_action :set_task_service
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_done]
  before_action :get_active_contexts, only: [:new, :edit]
  before_action :get_active_projects, only: [:new, :edit]

  def index
    @tasks = @task_service.get_active_tasks_of_current_user
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def toggle_done
    if @task_service.toggle_done(@task)
      render :json => {:error => 0, :success => 1}
    else
      render :status => 500
    end
  end

  def create
    task_form = TaskForm.new(task_params)
    respond_to do |format|
      if @task_service.create(task_form, current_user)
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    task_form = TaskForm.new(task_params)
    respond_to do |format|
      if @task_service.update(@task, task_form)
        format.html { redirect_to tasks_url, notice: 'Task was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    ###Soft delete:
    @task_service.soft_delete(@task)
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_task_service
      @task_service = TaskService.new(current_user)
    end

    def set_task
      @task = @task_service.get_task_by_id(params[:id])
      if @task.nil?
        raise ActionController::RoutingError.new('Given Task is null')
      end
    end

    def get_active_contexts
      @active_contexts = current_user.contexts.active
    end

    def get_active_projects
      @active_projects = current_user.projects.active
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :done, :deadline, :time_needed, :project_id, :context_id, :time_needed, :postponed_to)
    end
end
