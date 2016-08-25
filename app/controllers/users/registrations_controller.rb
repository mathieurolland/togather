class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    categories_path
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

end
