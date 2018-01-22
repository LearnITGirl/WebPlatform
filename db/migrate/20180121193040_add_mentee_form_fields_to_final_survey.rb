class AddMenteeFormFieldsToFinalSurvey < ActiveRecord::Migration
  def change
    add_column :final_surveys, :mentee_idea_pitch, :text
    add_column :final_surveys, :mentee_demo_url, :text
    add_column :final_surveys, :mentee_demo_file, :text
    add_column :final_surveys, :mentee_recap_and_future, :text
    add_column :final_surveys, :mentee_feedback, :text
  end
end
