class CreateFinalSurvey < ActiveRecord::Migration
  def change
    create_table :final_surveys do |t|
      t.integer :edition_id
      t.integer :mentor_id
      t.integer :mentee_id
      t.integer :project_id
      t.text :mentee_impression
      t.text :mentor_impression
      t.text :mentee_expectations
      t.text :mentor_expectations
      t.text :mentee_project_summary
      t.text :mentor_project_summary
      t.text :mentee_feedback
      t.text :mentor_feedback
      t.text :mentee_future_plans
      t.string :mentee_program_duration
      t.string :mentor_program_duration
      t.timestamps
    end
  end
end
