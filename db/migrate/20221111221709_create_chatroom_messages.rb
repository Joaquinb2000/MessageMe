class CreateChatroomMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chatroom_messages do |t|
      t.integer :message_id
    end
  end
end
