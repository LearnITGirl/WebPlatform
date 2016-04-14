class AddMidtermEvaluationFieldsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :mentor_evaluation, :string
    add_column :projects, :how_is_mentee_doing, :string
    add_column :projects, :mentor_work_is_as_he_described, :string
    add_column :projects, :github_evaluation, :string
  end
end
