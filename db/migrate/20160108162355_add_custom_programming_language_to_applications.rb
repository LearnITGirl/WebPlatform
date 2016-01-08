class AddCustomProgrammingLanguageToApplications < ActiveRecord::Migration
  def change
    add_column :mentee_applications, :other_programming_language, :string
    add_column :mentee_applications, :other_known_programming_language, :string
    add_column :mentor_applications, :other_programming_language, :string
  end
end
