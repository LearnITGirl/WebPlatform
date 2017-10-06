class AddMentorEvaluationToProject < ActiveRecord::Migration
  def up
    add_column :projects, :mentor_evaluation, :integer
  end
end