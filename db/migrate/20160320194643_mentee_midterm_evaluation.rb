class MenteeMidtermEvaluation < ActiveRecord::Migration
  def change
    create_table :mentee_midterm_evaluations do |t|
      t.integer :mentee_id
      t.text :project_progress
      t.text :language_progress
      t.text :positive_aspects
      t.text :future_plans
      t.integer :weekly_hours
      t.text :mentor_impression
      t.text :extra_info

      t.timestamps
    end
  end
end
