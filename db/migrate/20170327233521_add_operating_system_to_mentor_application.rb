class AddOperatingSystemToMentorApplication < ActiveRecord::Migration
  def change
    add_column :mentor_applications, :operating_system, :string
  end
end
