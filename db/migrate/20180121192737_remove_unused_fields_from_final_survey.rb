class RemoveUnusedFieldsFromFinalSurvey < ActiveRecord::Migration
  def change
    remove_column :final_surveys, :mentee_impression
    remove_column :final_surveys, :mentee_expectations
    remove_column :final_surveys, :mentee_project_summary
    remove_column :final_surveys, :mentee_feedback
    remove_column :final_surveys, :mentee_future_plans
    remove_column :final_surveys, :mentee_program_duration
  end
end
