class AddOtherProgrammingLanguagesToMenteeApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :mentee_applications, :other_programming_languages, :string, array: true, default: []
  end
end
