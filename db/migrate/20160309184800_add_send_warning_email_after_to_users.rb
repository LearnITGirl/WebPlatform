class AddSendWarningEmailAfterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :send_warning_email_after, :date
  end
end
