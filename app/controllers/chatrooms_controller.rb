class ChatroomsController < ApplicationController
  before_action :require_user

  def index
    @chatrooms = user_chatrooms.paginate(page: params[:page], per_page: 10).order('updated_at DESC')
    get_chatrooms_last_message(@chatrooms)
  end

  def show
    session[:chatroom_id] = params[:id]
    user_chatrooms 10
    @messages = params[:id].nil? ? Message.new : get_chatroom_messages(@chatrooms, params[:id])
    get_chatrooms_last_message(@chatrooms)
    @has_content = @messages.class == Array
    @message = Message.new
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def get_chatroom_messages(chatrooms, chatroom_id )
    chatrooms.find(chatroom_id).messages.includes(:user).custom_display
  end


# I created this to avoid having to make n+1 queries when checking the message's
# username. Is it better this way? or just getting the message model and rendering it
# with the message partial would have been better??
  def get_chatrooms_last_message(chatrooms)
    @last_messages = chatrooms.includes(:messages, :users).map do |chatroom|
      usernames = {}
      last_message = chatroom.messages.last
      chatroom.users.each {|user| usernames[user.id]= user.username}
      {username: usernames[last_message.user_id], body: last_message.body}
    end.to_enum
  end
end
