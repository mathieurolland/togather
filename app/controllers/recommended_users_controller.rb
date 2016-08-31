class RecommendedUsersController < ApplicationController
  def index
    @recommended_user = RecommendedUser.new
  end

  def create
    @recommended_user = RecommendedUser.new(email: recommended_user_params[:email], user: current_user)
    @recommended_user.save

    if @recommended_user.save
      #RecommendedMailer.creation_confirmation(@recommended_user).deliver_now
      redirect_to dashboard_path
    else
      render :index
    end
  end

  def update
    @recommended_user.update(recommended_user_params)
    @recommended_user.save
    redirect_to edit_user_registration_path
  end

  def destroy
    @recommended_user.destroy
    redirect_to edit_user_registration_path
  end

  def recommended_user_params
    params.require(:recommended_user).permit!
  end
end
