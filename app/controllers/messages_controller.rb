class MessagesController < ApplicationController
  before_action :require_user

  def create
    message = current_user.messages.build(message_body)
    message.chatroom_id = session[:chatroom_id]
    if message.save
      user_chatrooms.find(session[:chatroom_id]).update(updated_at: Time.now)
      ActionCable.server.broadcast "chatroom_channel",
                                    {mod_message: message_render(message),
                                    chatroom_id: session[:chatroom_id]}
    end
  end

  private

  def message_body
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end
end
