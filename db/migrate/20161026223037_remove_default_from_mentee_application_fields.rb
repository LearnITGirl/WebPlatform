class RemoveDefaultFromMenteeApplicationFields < ActiveRecord::Migration
  def change
    change_column_default(:mentee_applications, :communicating_in_english, nil)
    change_column_default(:mentee_applications, :send_to_mentor_confirmed, nil)
    change_column_default(:mentee_applications, :previous_programming_experience, nil)
  end
end
