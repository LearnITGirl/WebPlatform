class AddConfirmationEmailSentAtToApplication < ActiveRecord::Migration
  def change
    add_column :mentee_applications, :confirmation_email_sent_at, :datetime, default: nil
    add_column :mentor_applications, :confirmation_email_sent_at, :datetime, default: nil
  end
end
