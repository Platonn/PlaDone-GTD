class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Devise:
  before_action :authenticate_user!

  #Cancan try, spike
  #check_authorization

  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    #redirect_to root_url
    render 'public/404.html'
    #flash[:error] = exception.message
    #raise ActionController::RoutingError.new('Not Found')
  end

end
