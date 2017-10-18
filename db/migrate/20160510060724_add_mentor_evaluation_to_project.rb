class AddMentorEvaluationToProject < ActiveRecord::Migration
  def up
    add_column :projects, :mentor_evaluation, :integer unless Project.column_names.include?("mentor_evaluation")
  end
end