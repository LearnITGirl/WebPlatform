class AddPerceivedMethodToMentorApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :mentor_applications, :perceived_methods, :string, array: true, default: []
    add_column :mentor_applications, :perceived_other, :string
  end
end
