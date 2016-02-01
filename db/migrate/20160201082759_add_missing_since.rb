class AddMissingSince < ActiveRecord::Migration
  def change
    add_column(:users, :missing_since, :datetime)
  end
end
