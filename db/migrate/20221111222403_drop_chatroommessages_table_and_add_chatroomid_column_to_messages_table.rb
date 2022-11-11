class DropChatroommessagesTableAndAddChatroomidColumnToMessagesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :chatroom_messages

    add_column :messages, :chatroom_id, :integer
  end
end
