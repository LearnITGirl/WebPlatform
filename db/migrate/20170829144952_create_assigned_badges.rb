class CreateAssignedBadges < ActiveRecord::Migration
  def change
    create_table :assigned_badges do |t|
      t.integer :user_id
      t.integer :badge_id
      t.boolean :displayed, default: false
      t.timestamps
    end
    add_index :assigned_badges, [:user_id, :badge_id]
    add_index :assigned_badges, [:badge_id, :user_id]
  end
end
