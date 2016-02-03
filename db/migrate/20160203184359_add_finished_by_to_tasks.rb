class AddFinishedByToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :finished_by, :integer
  end
end
