class CreateProjectsTable < ActiveRecord::Migration
  def change
    create_table :projects_tables do |t|
      t.string :project_title
      t.string :language
      t.string :description
      t.integer :mentor_id
      t.integer :mentee_id
    end
  end
end
