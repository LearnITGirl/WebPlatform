class AddRegistrationToken < ActiveRecord::Migration
  def change 
    add_column :users, :registration_token, :string, :default => nil
  end
end
