class CreateMentorMidtermEvaluation < ActiveRecord::Migration
  def change
    create_table :mentor_midterm_evaluations do |t|
      t.integer :mentor_id
      t.integer :edition_id
      t.text :project_progress
      t.text :positive_aspects
      t.integer :weekly_hours
      t.text :future_plans
      t.text :mentee_impression
      t.text :extra_info

      t.timestamps
    end
  end
end
