class AddIsmissingMatchedidToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_missing, :boolean
    add_column :users, :matched_id, :integer
  end
end
