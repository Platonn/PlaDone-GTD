class ProjectCategoriesController < ApplicationController
  #load_and_authorize_resource
  before_action :set_project_category_id
  before_action :set_project_category_service
  before_action :set_project_category, only: [:show, :edit]
  before_action :get_active_contexts, only: [:new, :edit]
  before_action :get_active_projects, only: [:new, :edit]

  def index
    @project_categories = @project_category_service.get_active_project_categories_of(current_user)
  end

  def show
  end

  def new
    @project_category = ProjectCategory.new
  end

  def edit
  end

  def toggle_done
    if @project_category_service.toggle_done(@project_category_id, current_user)
      render :json => {:error => 0, :success => 1}
    else
      render :status => 500
    end
  end

  def create
    project_category_form = ProjectCategoryForm.new(project_category_params)
    respond_to do |format|
      if @project_category_service.create(project_category_form, current_user)
        format.html { redirect_to project_categories_url, notice: 'ProjectCategory was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    project_category_form = ProjectCategoryForm.new(project_category_params)
    respond_to do |format|
      if @project_category_service.update(@project_category_id, project_category_form, current_user)
        format.html { redirect_to project_categories_url, notice: 'ProjectCategory was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    ###Soft delete:
    @project_category_service.soft_delete(@project_category_id, current_user)
    respond_to do |format|
      format.html { redirect_to project_categories_url, notice: 'ProjectCategory was successfully destroyed.' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def set_project_category_service
    @project_category_service = ProjectCategoryService.new
  end

  def set_project_category_id
    @project_category_id = params[:id]
  end

  def set_project_category
    @project_category = @project_category_service.get_project_category_by_id(@project_category_id, current_user)
    raise ActionController::RoutingError.new('Given ProjectCategory is null') if @project_category.nil?
  end

  def get_active_contexts
    @active_contexts = current_user.contexts.active
  end

  def get_active_projects
    @active_projects = current_user.projects.active
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_category_params
    params.require(:project_category).permit(:name, :done, :deadline, :time_needed, :project_id, :context_id, :time_needed, :postponed_to)
  end
end
