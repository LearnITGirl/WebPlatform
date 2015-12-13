class ChangeEvaluationsModelScoreType < ActiveRecord::Migration
  def change
    change_column :evaluations, :score, :decimal
  end
end
