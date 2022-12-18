class AddProgrammingExperienceLevelToMentorApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :mentor_applications, :programming_experience_level, :jsonb
  end
end
