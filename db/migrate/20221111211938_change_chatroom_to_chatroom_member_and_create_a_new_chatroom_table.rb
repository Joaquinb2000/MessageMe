class ChangeChatroomToChatroomMemberAndCreateANewChatroomTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :chatrooms, :chatroom_members
    rename_column :chatroom_members, :message_id, :chatroom_id

    create_table :chatrooms do |t|
      t.timestamps
    end
  end
end
