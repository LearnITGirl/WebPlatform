class AddFieldsToMenteeApplication < ActiveRecord::Migration
  def change
    add_column :mentee_applications, :communicating_in_english, :boolean, default: false
    add_column :mentee_applications, :send_to_mentor_confirmed, :boolean, default: false
    add_column :mentee_applications, :operating_system, :string
    add_column :mentee_applications, :team_work_experience, :string
    add_column :mentee_applications, :previous_programming_experience, :boolean, default: false
  end
end
