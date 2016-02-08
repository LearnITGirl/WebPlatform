class AddConfimedToApplicationMatch < ActiveRecord::Migration
  def change
    add_column :application_matches, :confirmed, :boolean, default: :false
  end
end
