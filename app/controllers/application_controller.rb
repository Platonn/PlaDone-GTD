class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Devise:
  before_action :authenticate_user!

  #Cancan try, spike
  #check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url
    flash[:error] = exception.message
  end

end
