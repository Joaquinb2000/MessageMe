class ChatroomMember < ApplicationRecord
  validate :new_chatroom_member

  def new_chatroom_member
    if ChatroomMember.find_by(user_id: user_id, chatroom_id: chatroom_id )
      errors.add(:user, "is already a chatroom member")
    end
  end

  belongs_to :user
  belongs_to :chatroom
end
