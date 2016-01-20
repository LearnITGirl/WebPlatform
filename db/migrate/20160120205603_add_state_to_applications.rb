class AddStateToApplications < ActiveRecord::Migration
  def change
    add_column :mentor_applications, :state, :integer, limit: 1, default: 1
    add_column :mentee_applications, :state, :integer, limit: 1, default: 1
  end
end
