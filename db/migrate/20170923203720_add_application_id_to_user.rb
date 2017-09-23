class AddApplicationIdToUser < ActiveRecord::Migration
  def change
    add_reference :users, :mentee_application, index: true
    add_reference :users, :mentor_application, index: true
  end
end
