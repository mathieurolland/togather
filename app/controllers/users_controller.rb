class UsersController < ApplicationController

  def summary
    @user = User.find(params[:id])
  end

end
