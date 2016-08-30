class ConnectionsController < ApplicationController
  before_action :find_connection, only: [ :update, :show ]

  def index
    @connection = Connection.all
  end

  def create
    @connection = Connection.new(status: connections_params[:status], guest_id: current_user.id, host_id: @user.id)
    @Connection.save
    redirect_to connection_path(@connection.id)
  end

  def update
    if @connection.status == "suggested"
      @connection.status = "waiting"
      @connection.save
      @invers_connection = Connection.where(guest: @connection.host, host: current_user).first
      if @invers_connection
        @invers_connection.status = "invited"
      else
        @invers_connection = Connection.new(guest: @connection.host, host: current_user, status: "invited")
      end
      @invers_connection.save
      redirect_to connection_path(@connection.id)
    elsif @connection.status == "invited"
      @connection.destroy
      @invers_connection = Connection.where(guest: @connection.host, host: current_user).first
      @invers_connection.status = "valid"
      @invers_connection.save
      @meeting = Meeting.create(connection: @invers_connection)
      redirect_to connection_meeting_path(@connection, @meeting)
    end
  end

  def show
  end

  def finalize_status
    @meeting =  Meeting.find(params[:id])
    @connection = @meeting.connection
    @connection.update(status_params)
    if status_params[:status] == "connected"
      redirect_to connection_meeting_path(@connection, @meeting)
    else
      redirect_to dashboard_path
    end
  end

  private

  def find_connection
    @connection = Connection.find(params[:id])
  end

  def status_params
    params.require(:connection).permit(:status)
  end
end
