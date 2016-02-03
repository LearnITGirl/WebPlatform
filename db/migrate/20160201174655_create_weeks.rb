class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.datetime :start
      t.datetime :end
      t.integer :number
      t.references :edition
    end
  end
end
