class CreateEditions < ActiveRecord::Migration
  def change
    create_table :editions do |t|
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
