class AddProgrammingLanguagesInfoToMentorApplication < ActiveRecord::Migration
  def change
    add_column :mentor_applications, :programming_languages_info, :jsonb
  end
end
