class AddPerceivedMethodToMenteeApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :mentee_applications, :perceived_methods, :string, array: true, default: []
    add_column :mentee_applications, :perceived_other, :string
  end
end
