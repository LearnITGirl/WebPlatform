class AddParticipationDetailsToMenteeApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :mentee_applications, :previous_participation, :boolean, default: false
    add_column :mentee_applications, :previous_participation_types, :string, array: true, default: []
  end
end
