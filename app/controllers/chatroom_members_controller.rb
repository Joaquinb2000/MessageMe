class ChatroomMembersController < ApplicationController
  before_action :require_user
  before_action :is_chatroom_member

  def destroy
    user = User.find(params[:id])
    member = ChatroomMember.find_by(user_id: user.id, chatroom_id: session[:chatroom_id])
    if member
      user.messages.create(body: "Is no longer part of the chatroom", chatroom_id: member.chatroom_id)
      member.destroy()
      flash[:info] = "Succesfully removed user from chat"
    end
    redirect_to "/chatrooms/#{member.chatroom_id}/edit"
  end

end
