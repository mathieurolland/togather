class MeetingsController < ApplicationController

  def index
    @meetings = Meeting.all
  end

  def create
  end

  def update
  end

  def show
    @meeting = Meeting.find(params[:id])
    @connection = Connection.find(params[:connection_id])
    @messages = @meeting.messages
    @new_message = Message.new
  end
end
