require 'test_helper'

class MessageModelTest < ActionDispatch::IntegrationTest
  setup do
    create_users()
  end

  test "should create message" do
    User.first.chatrooms.create
    assert_difference "Message.count", 1 do
      User.first.messages.create(body: "Pumpkin pie man", chatroom_id: Chatroom.first.id)
    end
  end

  test "Should not create messages without chatroom_id" do
    assert_no_difference "Message.count" do
      User.first.messages.create(body: "testing my man")
    end
  end

  test "Should not create messages with invalid chatroom_id" do
    assert_no_difference "Message.count" do
      User.first.messages.create(body: "testing my man", chatroom_id: 245)
    end
  end
end
