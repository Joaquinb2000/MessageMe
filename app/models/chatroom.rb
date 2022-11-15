class Chatroom < ApplicationRecord
  has_many :chatroom_members
  has_many :users, through: :chatroom_members
  has_many :messages

  scope :recent, -> {order(:updated_at).reverse}
end
