class AddThumbnailsToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :thumbnail, :string
  end
end
