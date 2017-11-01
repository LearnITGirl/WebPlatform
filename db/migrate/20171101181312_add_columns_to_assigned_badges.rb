class AddColumnsToAssignedBadges < ActiveRecord::Migration
  def change
    add_column :assigned_badges, :week_id, :integer
    add_column :assigned_badges, :active, :boolean, default: true
    add_column :assigned_badges, :upgrade, :boolean, default: false
    add_column :assigned_badges, :upgraded_from, :integer
  end
end
