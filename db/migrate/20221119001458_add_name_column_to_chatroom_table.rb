class AddNameColumnToChatroomTable < ActiveRecord::Migration[5.2]
  def change
    add_column :chatroom_members, :name, :string
  end
end
