class AddRoadmapToMentorApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :mentor_applications, :roadmap, :string
  end
end
