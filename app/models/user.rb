class User < ApplicationRecord
  validates :username, presence: true, length: {minimu: 3, maximum: 15},
                       uniqueness: { case_sensitive: false }

  validates :password_digest, length: { minimum: 8 }

  has_many :chatroom_members, dependent: :destroy
  has_many :chatrooms, through: :chatroom_members
  has_many :messages
  has_secure_password
end
