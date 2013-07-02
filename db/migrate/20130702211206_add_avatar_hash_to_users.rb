class AddAvatarHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_hash, :string
  end
end
