class ProjectLogEntriesController < ApplicationController
  respond_to :html, :json

  before_action :set_project_log_entry, only: [:show, :edit, :update, :destroy]


  def index
    @project_log_entries = ProjectLogEntry.all
    respond_with(@project_log_entries)
    end
  
  def show
    respond_with(@project_log_entry)
    end
  
  def new
    @project_log_entry = ProjectLogEntry.new
    respond_with(@project_log_entry)
    end
  
  def edit
    end
  
  def create
    @project_log_entry = ProjectLogEntry.new(project_log_entry_params)
    @project_log_entry.save
    respond_with(@project_log_entry)
    end
  
  def update
    @project_log_entry.update(project_log_entry_params)
    respond_with(@project_log_entry)
    end
  
  def destroy
    @project_log_entry.destroy
    respond_with(@project_log_entry)
    end
  
  private
    def set_project_log_entry
      @project_log_entry = ProjectLogEntry.find(params[:id])
    end
  
    def project_log_entry_params
      params.require(:project_log_entry).permit(:project_id, :task_id, :user_id, :activity_type, :previous_value, :new_value)
    end
  end