class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead
  include ActiveDevice
  helper :all
  # protect_from_forgery with: :exception
  protect_from_forgery
  before_action :prepare_for_mobile 
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  def not_found
    flash[:error] = "No App"
    redirect_to root_url
  end
 
private

 def mobile_device?
  if session[:mobile_param]
    session[:mobile_param] == "1"
  else
    request.user_agent =~ /Mobile|webOS/
  end
 end
 helper_method :mobile_device?


 def prepare_for_mobile
  session[:mobile_param] = params[:mobile] if params[:mobile]
  request.format = :mobile if mobile_device?
 end
  
  rescue_from CanCan::AccessDenied do |exception|
   flash[:error] = "Access denied! on #{exception.action} #{exception.subject.inspect}"
   redirect_to root_url
  end

  protected
	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
	end


end
