class AddLastCommitDateToProject < ActiveRecord::Migration
  def up
    add_column :projects, :last_commit, :datetime
  end

  def down
    remove_column :projects, :last_commit, :datetime
  end
end
