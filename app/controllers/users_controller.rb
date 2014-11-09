class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    #authorize! :show, @users
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.build(user_params)

    if params[:is_admin]
      @user.roles << :admin unless @user.roles.include?(:admin)
    else
      @user.roles.delete(:admin) if @user.roles.include?(:admin)
    end

    @user.save

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #If password is blank, devise should not validate it, comparing with password_confirmation
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

    if params[:is_admin]
      @user.roles << :admin unless @user.roles.include?(:admin)
    else
      @user.roles.delete(:admin) if @user.roles.include?(:admin)
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #Prevent self destroying!
    if @user.id == current_user.id
      format.html { redirect_to users_url, error: "You cannot delete yourself." }
      format.json { render :show, status: :ok, location: @user }
    else

      @user.destroy
      ### Soft delete - spike: todo in future
      #@project_category.soft_delete
      respond_to do |format|
        format.html { redirect_to project_categories_url, notice: 'Project category was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :is_admin)
  end
end
