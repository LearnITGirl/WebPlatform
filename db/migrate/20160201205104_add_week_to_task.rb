class AddWeekToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :week, :integer
  end
end
