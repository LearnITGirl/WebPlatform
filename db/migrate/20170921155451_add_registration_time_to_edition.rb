class AddRegistrationTimeToEdition < ActiveRecord::Migration
  def up
    add_column :editions, :registration_started_at, :datetime
    add_column :editions, :registration_closed_at, :datetime
  end

  def down
    remove_column :editions, :registration_started_at
    remove_column :editions, :registration_closed_at
  end
end
