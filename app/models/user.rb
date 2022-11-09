class User < ApplicationRecord
  validates :username, presence: true, length: {minimu: 3, maximum: 15},
                       uniqueness: { case_sensitive: false }

  has_many :messages
  has_secure_password
end
