class CreateApplicationMatch < ActiveRecord::Migration
  def change
    create_table :application_matches do |t|
      t.references :mentor_application
      t.references :mentee_application
    end
  end
end
