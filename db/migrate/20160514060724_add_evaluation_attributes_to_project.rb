class AddEvaluationAttributesToProject < ActiveRecord::Migration
  def change
  	change_column :projects, :mentor_evaluation, :integer
    add_column :projects, :mentee_feedback, :integer
    add_column :projects, :mentee_project_status, :integer
    add_column :projects, :github_repo_status, :integer
    add_column :projects, :midterm_evaluation_status, :integer, :default => 0
  end
end
