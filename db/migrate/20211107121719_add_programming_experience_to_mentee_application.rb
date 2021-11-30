class AddProgrammingExperienceToMenteeApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :mentee_applications, :programming_experience_level, :jsonb
    add_column :mentee_applications, :programming_experience_detail, :jsonb
  end
end
