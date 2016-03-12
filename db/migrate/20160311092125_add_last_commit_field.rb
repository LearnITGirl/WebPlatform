class AddLastCommitField < ActiveRecord::Migration
  def change
    add_column :projects, :last_commit, :datetime
  end
end
