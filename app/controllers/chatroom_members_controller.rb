class ChatroomMembers < ApplicationController
  before_action :require_user
  before_action :chatroom_members

  def show
    session[:add_to_chatroom] = @chatroom_members.find_by(username: params.permit(:username)).username
  end

  private

  def chatroom_members
    @chatroom_members = Chatroom.find(params[:id]).users
  end
end
