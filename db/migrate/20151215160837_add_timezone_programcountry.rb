class AddTimezoneProgramcountry < ActiveRecord::Migration
  def change
    add_column :users, :program_country, :string
    add_column :users, :timezone, :string
  end
end
