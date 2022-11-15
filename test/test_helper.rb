ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'faker'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_users(users = 5)
    users.times do
      User.create(username: Faker::Internet.user[:username], password: "password")
    end
  end

  def build_message(user, chatroom)
    user.messages.build( body: Faker::Marketing.buzzwords, chatroom_id: chatroom.id )
  end

  def login(user)
    post login_path, params: {session: {username: user.username, password: "password" }}
  end
end
