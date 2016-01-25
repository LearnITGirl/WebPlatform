class AddNameToEditions < ActiveRecord::Migration
  def change
    add_column :editions, :name, :string
  end
end
