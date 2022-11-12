ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_users(users = 5)
    require 'faker'
    users.times do
      user = User.create(username: Faker::Internet.user[:username], password: "password")
      end
  end
end
