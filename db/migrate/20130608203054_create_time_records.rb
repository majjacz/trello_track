class CreateTimeRecords < ActiveRecord::Migration
  def change
    create_table :time_records do |t|
      t.references :task, index: true, :null => false
      t.datetime :start_time, :null => false
      t.datetime :end_time

      t.timestamps
    end
  end
end
