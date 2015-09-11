class CreateMenteeApplication < ActiveRecord::Migration
  def change
    create_table :mentee_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :gender
      t.string :country
      t.string :program_country
      t.string :time_zone
      t.text :motivation
      t.string :english_level
      t.text :experience
      t.string :programming_level
      t.text :background
      t.string :known_programming_languages, array:true, default: []
      t.string :programming_language
      t.text :project_proposal
      t.text :programming_experience
      t.text :roadmap
      t.integer :time_availability, limit: 1
      t.string :engagements, array:true, default: []
      t.string :sources, array:true, default: []
      t.string :build_step
      t.timestamps
    end
  end
end
