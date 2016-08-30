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
    @connection = @meeting.connection
    @messages = @meeting.messages
    @new_message = Message.new
    if @connection.guest == current_user
      @other_meeter = @connection.host
      @current_review = @meeting.guest_review
      @other_review = @meeting.host_review
    else
      @other_meeter = @connection.guest
      @current_review = @meeting.host_review
      @other_review = @meeting.guest_review
    end
  end

  def change_review
    @meeting = Meeting.find(params[:id])
    @connection = @meeting.connection
    @meeting.update(review_params)
    redirect_to connection_meeting_path(@connection, @meeting)
  end

  def edit_review
    @meeting = Meeting.find(params[:id])
    @connection = @meeting.connection
  end

  def destroy_review
    @meeting = Meeting.find(params[:id])
    @connection = @meeting.connection
    if @connection.guest == current_user
      @meeting.guest_review = ""
    else
      @meeting.host_review = ""
    end
    @meeting.save
    redirect_to connection_meeting_path(@connection, @meeting)
  end

  private

  def review_params
    params.require(:meeting).permit(:host_review, :guest_review)
  end

end
