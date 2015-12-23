class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :language
      t.text :description
      t.string :github_link
      t.integer :mentor_id
      t.integer :mentee_id
    end
  end
end
