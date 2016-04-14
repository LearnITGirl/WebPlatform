class CreateMidtermEvaluations < ActiveRecord::Migration
  def self.up
    add_column :mentor_midterm_evaluations, :project_id, :integer
    add_column :projects, :mentor_midterm_evaluation_id, :integer
    add_index :projects, :mentor_midterm_evaluation_id
    add_column :mentee_midterm_evaluations, :project_id, :integer
    add_column :projects, :mentee_midterm_evaluation_id, :integer
    add_index :projects, :mentee_midterm_evaluation_id
    add_column :projects, :midterm_evaluation_completed, :boolean, default: false

    Project.all.each do |p|
      p.mentee_midterm_evaluation = p.mentee.mentee_midterm_evaluation
      p.mentor_midterm_evaluation = p.mentor.mentor_midterm_evaluation
      if p.valid?
        p.save!
      end
    end
  end

  def self.down
    remove_column :mentor_midterm_evaluations, :project_id, :integer
    remove_column :projects, :mentor_midterm_evaluation_id, :integer
    remove_column :mentee_midterm_evaluations, :project_id, :integer
    remove_column :projects, :mentee_midterm_evaluation_id, :integer
    remove_column :projects, :midterm_evaluation_completed
  end
end
