class MessagesController < ApplicationController
  before_action :require_user
  def create
    message = current_user.messages.build(message_params)
    if message.save
      # redirect_to root_path
      ActionCable.server.broadcast "chatroom_channel", mod_message: render_message(message)
    end
  end

  private

  def message_params
     params.require(:message).permit(:body)
  end

  def render_message(message)
    render(partial: 'message', locals: {message:message})
  end
end