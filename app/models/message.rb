class Message < ApplicationRecord
  validates :body, presence: true
  after_save :update_chatroom

  belongs_to :chatroom
  belongs_to :user

  def update_chatroom
    self.chatroom.update(updated_at: Time.now)
  end

  scope :custom_display, -> { order(:created_at).last(20) }
end
