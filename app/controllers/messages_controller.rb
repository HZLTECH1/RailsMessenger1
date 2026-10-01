class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [ :create ]
  def index
    @messages = Message.all
    @message = Message.new
  end
  def create
      @message = Message.new(content: params[:message][:content], image: params[:message][:image], user: current_user)
      if @message.save
        flash[:message_creation_success] = "Message Create Successfully!"
      else
        flash[:message_creation_fail] = "Failed To Save Message!"
      end
      redirect_to root_path
  end

  private
  def create_message_params
    params.require(:message).permit(:content, :image)
  end
end
