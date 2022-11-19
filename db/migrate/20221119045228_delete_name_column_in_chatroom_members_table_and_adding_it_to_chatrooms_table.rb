class DeleteNameColumnInChatroomMembersTableAndAddingItToChatroomsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :chatrooms, :name, :string

    remove_column :chatroom_members, :name, :string
  end
end
