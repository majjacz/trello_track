class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project, index: true, :null => false
      t.references :user, index: true, :null => false
      t.string :name
      t.string :card_id

      t.timestamps
    end
  end
end
