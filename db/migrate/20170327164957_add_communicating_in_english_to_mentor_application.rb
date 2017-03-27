class AddCommunicatingInEnglishToMentorApplication < ActiveRecord::Migration
  def change
    add_column :mentor_applications, :communicating_in_english, :boolean
  end
end
