class AddEvaluationAttributesToProject < ActiveRecord::Migration
  def up
    change_column :projects, :mentor_evaluation, 'integer USING CAST(mentor_evaluation AS integer)'
    add_column :projects, :mentee_feedback, :integer
    add_column :projects, :mentee_project_status, :integer
    add_column :projects, :github_repo_status, :integer
    add_column :projects, :midterm_evaluation_status, :integer, :default => 0
  end

  def down
    change_column :projects, :mentor_evaluation, :string
    remove_column :projects, :mentee_feedback, :integer
    remove_column :projects, :mentee_project_status, :integer
    remove_column :projects, :github_repo_status, :integer
    remove_column :projects, :midterm_evaluation_status, :integer, :default => 0
  end
end
