class Chatroom < ApplicationRecord
  before_save {|chatroom| chatroom.name = nil if chatroom.name == ""}
  validates :name, length:{maximum:25}

  has_many :chatroom_members, dependent: :destroy
  has_many :users, through: :chatroom_members
  has_many :messages, dependent: :destroy

  scope :recent, -> {order(updated_at: :desc)}
end
