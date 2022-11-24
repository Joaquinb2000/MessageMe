class ChatroomsController < ApplicationController
  before_action :require_user
  before_action :set_chatroom, only: [:edit, :update, :destroy ]
  before_action :is_chatroom_member, only:[ :update, :destroy ]

  def index
    @chatrooms = user_chatrooms.paginate(page: params[:page], per_page: 10).order('updated_at DESC')
    get_chatrooms_last_message(@chatrooms)
  end

  def show
    session[:chatroom_id] = params[:id]
    is_chatroom_member
    current_chatroom
    user_chatrooms 10
    @messages = params[:id].nil? ? Message.new : get_chatroom_messages(@current_chatroom)
    get_chatrooms_last_message(@chatrooms)
    @has_content = @messages.class == Array
    @message = Message.new
  end

  def new
    user_id = params[:friend]
    @friend = User.find_by(id: user_id)
    @chatroom = Chatroom.new
  end

  def create
    user = User.find_by(username: username_param)
    @chatroom = Chatroom.new(chatroom_params)

    if user && user != current_user && @chatroom.save()
      @chatroom.users.push(current_user, user)
      @chatroom.messages.create(body: "Opened the chatroom!", user_id: current_user.id)
      flash[:info]= "Succesfully created the chatroom!"
      redirect_to "/chatroom/#{@chatroom.id}"
    else
      @errors = creation_errors(@chatroom, user)
      render "new"
    end
  end

  def edit
    session[:chatroom_id] = params[:id]
    is_chatroom_member
    @members = @chatroom.users.paginate(page: params[:page], per_page: 10)
  end

  def update
    user = User.find_by(username: username_param)
    if @chatroom.update(chatroom_params) || (user && user != current_user)
      @chatroom.users <<  user if user
      flash[:info]= "Succesfully updated the chatroom!"
      redirect_to "/chatroom/#{@chatroom.id}"
    else
      @errors = creation_errors(@chatroom, user)
      redirect_to edit_chatroom_path @chatroom
    end
  end

  def destroy
    if current_chatroom
      @chatroom.destroy
      session[:chatroom_id]= nil
      flash[:info] = "Chatroom succesfully deleted"
    end
    redirect_to "/chatroom"
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def get_chatroom_messages(chatroom)
    chatroom.messages.includes(:user).custom_display
  end

# I created this to avoid having to make n+1 queries when checking the message's
# username. Is it better this way? or just getting the message model and rendering it
# with the message partial would have been better??
  def get_chatrooms_last_message(chatrooms)
    @last_messages = chatrooms.includes(:messages, :users).map do |chatroom|
      usernames = {}
      last_message = chatroom.messages.last
      chatroom.users.each {|user| usernames[user.id]= user.username}
      username||= usernames[last_message.user_id] || User.find(last_message.user_id).username
      {username: username, body: last_message.body}
    end.to_enum
  end

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end

  def username_param
    params.require(:chatroom).permit(:user)[:user].downcase
  end

  def creation_errors(chatroom, user)
    chatroom.valid?
    errors = chatroom.errors.full_messages
    errors << "Username does not exist" if user.nil?
    errors << "User is already member of the chat" if user == current_user
    errors
  end

end
