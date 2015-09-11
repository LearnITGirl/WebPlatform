class RenameMentorToMentorApplication < ActiveRecord::Migration
  def change
    rename_table :mentors, :mentor_applications
  end
end
