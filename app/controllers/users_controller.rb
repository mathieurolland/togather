class UsersController < ApplicationController

  def summary
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:product).permit(:first_name, :last_name, :email, :birthday, :gender, :work_place, :bio, :photo)
  end

end
