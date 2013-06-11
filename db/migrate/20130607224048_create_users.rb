class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.text :email
      t.string :provider
      t.string :uid
      t.text :oauth_hash
      t.string :auth_token
      t.string :api_key

      t.timestamps
    end
  end
end
