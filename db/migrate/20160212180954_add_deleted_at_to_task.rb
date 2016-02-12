class AddDeletedAtToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :deleted_at, :datetime
  end
end
