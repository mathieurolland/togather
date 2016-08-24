class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    categories_path
  end

end
