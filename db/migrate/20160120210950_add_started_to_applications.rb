class AddStartedToApplications < ActiveRecord::Migration
  def change
    add_column :mentor_applications, :started, :boolean, default: false
    add_column :mentee_applications, :started, :boolean, default: false
  end
end
