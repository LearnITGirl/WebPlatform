class AddProgramFeedbackToMidtermEvaluations < ActiveRecord::Migration[4.2]
  def change
  	add_column :mentee_midterm_evaluations, :program_feedback, :text, :after => :mentor_impression
  	add_column :mentor_midterm_evaluations, :program_feedback, :text, :after => :mentee_impression
  end
end