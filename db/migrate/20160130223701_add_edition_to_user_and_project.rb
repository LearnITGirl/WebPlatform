class AddEditionToUserAndProject < ActiveRecord::Migration
  def change
    add_reference :users, :edition
    add_reference :projects, :edition
  end
end
