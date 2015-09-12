class CreateMentors < ActiveRecord::Migration
  def change
    create_table :mentors do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :gender
      t.string :country
      t.string :program_country
      t.string :time_zone
      t.text :motivation
      t.string :english_level
      t.string :mentee_level, array:true, default: []
      t.boolean :experienced, default: false
      t.text :mentor_experience
      t.text :background
      t.boolean :git, default: false
      t.string :programming_languages, array:true, default: []
      t.text :programming_experience
      t.text :application_idea
      t.text :concept_explanation
      t.integer :time_availability, limit: 1
      t.string :engagements, array:true, default: []
      t.string :sources, array:true, default: []
      t.string :build_step
      t.timestamps
    end
  end
end
