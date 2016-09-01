class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if current_user.status == true
      partner_path
    else
      if RecommendedUser.find_by_email(current_user.email)
        current_user.update(photo_url: "https://t3.ftcdn.net/jpg/00/53/51/66/160_F_53516657_zFxg5J7wKRaRmjn00ez578LuO8WuSOOH.jpg")
        godfather = RecommendedUser.find_by_email(current_user.email).user
        Connection.create!(status: "connected", guest: godfather, host: current_user)
        categories_path
      else
        current_user.destroy
        root_path
      end
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
