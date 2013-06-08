class AddOauthHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_hash, :text
  end
end
