class MeetingsController < ApplicationController
  before_action :find_connection_meeting, only: [ :show, :change_review, :edit_review, :destroy_review ]

  def index
    @meetings = Meeting.all
  end

  def create
  end

  def update
  end

  def show
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
    if @meeting.update(review_params)
      redirect_to connection_meeting_path(@connection, @meeting)
    else
      render :edit
    end
  end

  def edit_review
  end

  def destroy_review
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

  def find_connection_meeting
    @meeting = Meeting.find(params[:id])
    @connection = @meeting.connection
  end
end
