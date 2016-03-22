class AddEditionToMenteeMidtermEvaluations < ActiveRecord::Migration
  def change
    add_column :mentee_midterm_evaluations, :edition_id, :integer
  end
end
