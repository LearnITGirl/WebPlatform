class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :answer
      t.timestamps
    end
  end
end
