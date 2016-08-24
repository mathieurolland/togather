class ConnectionsController < ApplicationController

  def index
    @connection = Connection.all
  end

  def create
    @connection = Connection.new(status: connections_params[:status], guest_id: current_user.id, host_id: @user.id)
    @Connection.save
    redirect_to connection_path(@connection.id)
  end

  def update
  end

  def show
    @connection = Connection.find(params[:id])
  end
end
