class RemoveMatchedIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :matched_id, :integer
  end
end
