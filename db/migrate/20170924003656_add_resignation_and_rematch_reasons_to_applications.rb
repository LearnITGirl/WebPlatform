class AddResignationAndRematchReasonsToApplications < ActiveRecord::Migration
  def change
    add_column :mentor_applications, :resignation_reason, :text
    add_column :mentor_applications, :rematch_reason, :text
    add_column :mentee_applications, :resignation_reason, :text
    add_column :mentee_applications, :rematch_reason, :text
  end
end
