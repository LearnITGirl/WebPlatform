class CreateProgrammingLanguages < ActiveRecord::Migration
  def change
    rename_column :mentee_applications, :programming_language, :old_programming_language
    rename_column :mentor_applications, :programming_languages, :old_programming_languages
    create_table :programming_languages do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
    create_join_table :mentor_applications, :programming_languages
    add_reference :mentee_applications, :programming_language
  end
end
