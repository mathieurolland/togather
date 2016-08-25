class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if current_user.status == true
      partner_path
    else
      dashboard_path
    end
  end

  def after_sign_in_path_for(resource)
    if current_user.status == true
      partner_path
    else
      dashboard_path
    end
  end

end
