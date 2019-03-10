class CreateRoadmapEntries < ActiveRecord::Migration
  def up
    create_table :roadmap_entries do |t|
      t.references :project
      t.references :week
      t.references :edition
      t.text :content
      t.timestamps
    end
  end

  def down
    drop_table :roadmap_entries
  end
end
