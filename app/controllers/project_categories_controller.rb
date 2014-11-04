class ProjectCategoriesController < ApplicationController
  before_action :set_project_category, only: [:show, :edit, :update, :destroy]

  # GET /project_categories
  # GET /project_categories.json
  def index
    @project_categories = ProjectCategory.all
  end

  # GET /project_categories/1
  # GET /project_categories/1.json
  def show
  end

  # GET /project_categories/new
  def new
    @project_category = ProjectCategory.new
  end

  # GET /project_categories/1/edit
  def edit
  end

  # POST /project_categories
  # POST /project_categories.json
  def create
    @project_category = ProjectCategory.new(project_category_params)

    respond_to do |format|
      if @project_category.save
        format.html { redirect_to @project_category, notice: 'Project category was successfully created.' }
        format.json { render :show, status: :created, location: @project_category }
      else
        format.html { render :new }
        format.json { render json: @project_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_categories/1
  # PATCH/PUT /project_categories/1.json
  def update
    respond_to do |format|
      if @project_category.update(project_category_params)
        format.html { redirect_to @project_category, notice: 'Project category was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_category }
      else
        format.html { render :edit }
        format.json { render json: @project_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_categories/1
  # DELETE /project_categories/1.json
  def destroy
    @project_category.destroy
    respond_to do |format|
      format.html { redirect_to project_categories_url, notice: 'Project category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_category
      @project_category = ProjectCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_category_params
      params.require(:project_category).permit(:name)
    end
end
