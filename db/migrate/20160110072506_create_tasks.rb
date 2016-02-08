class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :creator_id
      t.datetime :created_at
      t.integer :status, limit:1
      t.integer :project_id
    end
  end
end
