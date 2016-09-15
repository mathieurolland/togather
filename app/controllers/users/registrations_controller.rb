class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if current_user.status == true
      partner_path
    else
      if RecommendedUser.find_by_email(current_user.email)
        #current_user.update(photo_url: "https://t3.ftcdn.net/jpg/00/53/51/66/160_F_53516657_zFxg5J7wKRaRmjn00ez578LuO8WuSOOH.jpg")
        current_user.update(photo_url: "https://scontent.xx.fbcdn.net/v/t1.0-9/13393913_10153647120416299_6568716079801929041_n.jpg?oh=d469bbf9cd538a46cce11a8673a42bea&oe=5849A552")
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
