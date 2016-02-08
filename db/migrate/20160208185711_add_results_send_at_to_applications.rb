class AddResultsSendAtToApplications < ActiveRecord::Migration
  def change
    add_column :mentee_applications, :results_send_at, :datetime
    add_column :mentor_applications, :results_send_at, :datetime
    add_column :users, :results_send_at, :datetime
  end
end
