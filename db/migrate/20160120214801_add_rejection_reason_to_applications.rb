class AddRejectionReasonToApplications < ActiveRecord::Migration
  def change
    add_column :mentee_applications, :rejection_reason, :text
    add_column :mentor_applications, :rejection_reason, :text
  end
end
