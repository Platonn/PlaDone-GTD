class ContextsController < ApplicationController
  #load_and_authorize_resource
  before_action :set_context_id
  before_action :set_context_service
  before_action :set_context, only: [:show, :edit]

  def index
    @contexts = @context_service.get_active_contexts_of(current_user)
  end

  def show
  end

  def new
    @context = Context.new
  end

  def edit
  end

  def create
    context_form = ContextForm.new(context_params)
    respond_to do |format|
      if @context_service.create(context_form, current_user)
        format.html { redirect_to contexts_url, notice: 'Context was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    context_form = ContextForm.new(context_params)
    respond_to do |format|
      if @context_service.update(@context_id, context_form, current_user)
        format.html { redirect_to contexts_url, notice: 'Context was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    ###Soft delete:
    @context_service.soft_delete(@context_id, current_user)
    respond_to do |format|
      format.html { redirect_to contexts_url, notice: 'Context was successfully destroyed.' }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.

  def set_context_service
    @context_service = ContextService.new
  end

  def set_context_id
    @context_id = params[:id]
  end

  def set_context
    @context = @context_service.get_context_by_id(@context_id, current_user)
    raise ActionController::RoutingError.new('Given Context is null') if @context.nil?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def context_params
    params.require(:context).permit(:name, :color, :icon)
  end
end



