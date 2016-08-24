class ConnectionsController < ApplicationController

  def index
    @connection = Connection.all
  end

  def create
    @connection = Connection.new(status: connections_params[:status], guest: current_user, host: @user)
    @Connection.save
    redirect_to connection_path(@connection.id)
  end

  def update
  end

  def show
    @connection = Connection.find(params[:id])
  end
end
