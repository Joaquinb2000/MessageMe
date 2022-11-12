class ChatroomsController < ApplicationController
  before_action :require_user

  def index
    user_chatrooms.paginate(page: params[:page])
  end

  def show
    session[:chatroom_id] = params[:id]
    user_chatrooms
    @messages = params[:id].nil? ? Message.new : get_chatroom_messages(@chatrooms, params[:id])
    @has_content = @messages.class == Array
    @message = Message.new
    end
  end


  def get_chatroom_messages(chatrooms, chatroom_id )
    chatrooms.find(chatroom_id).messages.custom_display
  end
end
