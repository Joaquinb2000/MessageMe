require "application_system_test_case"

class ChatroomChannelTest < ApplicationSystemTestCase
  setup do
    create_users 10

    30.times do
      user = User.all.sample
      chatroom = user.chatrooms.create()
      build_message(user, chatroom).save

      rand(2..5).times do
        members = chatroom.users.map{|user| user.id}
        new_member = User.where.not(id: members).sample
        chatroom.users << new_member
        build_message(new_member, chatroom).save
      end
    end
  end


  test "chatrooms index page should display last message live" do
    chatroom = Chatroom.first
    user_1, user_2 = chatroom.users.take 2

    visit login_url
    fill_in('Username', with: user_1.username)
    fill_in('Password', with: "password")
    click_on "Login"

    chatrooms = user_1.chatrooms.length
    chatrooms= 10 if chatrooms > 10

    visit chatrooms_url

    assert_selector "a.ui.chatpreview", {count: chatrooms}


    using_session("user_2") do
      visit login_url
      fill_in('Username', with: user_1.username)
      fill_in('Password', with: "password")
      click_on "Login"

      visit "/chatroom/#{chatroom.id}"

      assert_difference 'Chatroom.first.messages.count', 1 do
        find_by_id("message_body").fill_in(with: "Kono ude daite omae wo nidoto hanashi wa shinai")
        find(:id, 'send-message').click
        sleep 3 # Waits three seconds to allow data to be saved in the DB
      end
    end
    assert_text ("Kono ude daite omae wo nidoto hanashi wa shinai")
  end
end
