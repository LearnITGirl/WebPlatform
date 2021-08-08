class AddNewLearningsToMenteeApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :mentee_applications, :new_learnings, :string
  end
end
