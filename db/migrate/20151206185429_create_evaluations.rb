class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.float :score
      t.references :mentor_application
      t.references :mentee_application
      t.references :user
    end
  end
end
