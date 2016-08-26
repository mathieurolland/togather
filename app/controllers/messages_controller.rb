class MessagesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js

   def create
    @meeting = Meeting.find(params[:meeting_id])
    @message = current_user.messages.new(message_params)
    @message.meeting = @meeting
    @connection = @meeting.connection

    if @message.save
      # sync_new @message
      redirect_to connection_meeting_path(@connection, @meeting)
    else
      render '../meeting_show'
    end

    # respond_with { @message }

  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
