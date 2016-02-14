class AddUpdatedAt < ActiveRecord::Migration
  def change
     add_column :tasks, :updated_at, :datetime
  end
end
