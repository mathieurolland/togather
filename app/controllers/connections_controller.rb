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
    @connection = Connection.find(params[:id])
    if @connection.status == "suggested"
      @connection.status = "invited"
      @connection.save
      if Connection.where(guest: @connection.host, host: current_user).first
        @invers_connection = Connection.where(guest: @connection.host, host: current_user).first
        @invers_connection.status = "waiting"
      else
        @invers_connection = Connection.new(guest: @connection.host, host: current_user, status: "waiting")
      end
      @invers_connection.save
      redirect_to connection_path(@connection.id)
    elsif @connection.status == "invited"
      @connection.status = "valid"
      @connection.save
      @meeting = Meeting.create(connection: @connection)
      redirect_to connection_meeting_path [@connection, @meeting]
    end
  end

  def show
    @connection = Connection.find(params[:id])
  end
end
