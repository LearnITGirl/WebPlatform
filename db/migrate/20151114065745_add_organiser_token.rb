class AddOrganiserToken < ActiveRecord::Migration
  def change
    add_column :users, :organiser_token, :string, :default => nil
  end
end
