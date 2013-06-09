class CreateTimeRecords < ActiveRecord::Migration
  def change
    create_table :time_records do |t|
      t.references :user, index: true, :null => false
      t.string :trello_board_id, :null => false
      t.string :trello_card_id, :null => false
      t.string :name, :null => false
      t.datetime :start_time, :null => false
      t.datetime :end_time
      t.boolean :paused, :default => false
      t.integer :paused_for, :default => 0

      t.timestamps
    end
  end
end
