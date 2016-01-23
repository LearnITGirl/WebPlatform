class AddEvaluatorToApplications < ActiveRecord::Migration
  def change
    remove_column :mentor_applications, :started, :boolean
    remove_column :mentee_applications, :started, :boolean

    add_column :mentor_applications, :evaluator_id, :integer
    add_column :mentee_applications, :evaluator_id, :integer
  end
end
