class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :bio, :work_place, :password, :gender, :birthday, :status])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :bio, :work_place, :password, :gender, :birthday, :status])
  end
end
