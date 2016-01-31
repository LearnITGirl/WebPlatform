class AddTimestampsToApplicationMatches < ActiveRecord::Migration
  def change
    add_column(:application_matches, :created_at, :datetime)
    add_column(:application_matches, :updated_at, :datetime)
  end
end
