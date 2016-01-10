class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :creator_id
      t.datetime :created_at
      t.boolean :completed, :default: false
      t.integer :project_id
     
    end
  end
end
