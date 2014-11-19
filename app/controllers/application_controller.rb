class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #Allow sanitizer
  before_filter :configure_permitted_parameters, if: :devise_controller?

protected

 def configure_permitted_parameters
 	#Allow the these parameters to be passed to devise in user registration
    devise_parameter_sanitizer.for(:sign_up) <<:fname <<:lname <<:name <<:admin <<:organization_id
 end
end
