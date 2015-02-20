class ProjectsController < ApplicationController
  #load_and_authorize_resource
  before_action :set_project_id
  before_action :set_project_service
  before_action :set_project, only: [:show, :edit]
  before_action :get_active_project_categories, only: [:new, :edit]

  def index
    @projects = @project_service.get_active_projects_of(current_user)
  end

  def show
    @project_log_entries = @project_service.get_history(@project_id)
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    project_form = ProjectForm.new(project_params)
    respond_to do |format|
      project = @project_service.create(project_form, current_user)
      if project
        format.html { redirect_to project_url(project.id), notice: 'Project was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    project_form = ProjectForm.new(project_params)
    respond_to do |format|
      if @project_service.update(@project_id, project_form, current_user)
        format.html { redirect_to project_url(@project_id), notice: 'Project was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    ###Soft delete:
    @project_service.soft_delete(@project_id, current_user)
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.

  def set_project_service
    @project_service = ProjectService.new
  end

  def set_project_id
    @project_id = params[:id]
  end

  def set_project
    @project = @project_service.get_project_by_id(@project_id, current_user)
    raise ActionController::RoutingError.new('Given Project is null') if @project.nil?
  end

  def get_active_project_categories
    @active_project_categories = current_user.project_categories.active
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :deadline, :project_category_id, :notes)
  end
end






