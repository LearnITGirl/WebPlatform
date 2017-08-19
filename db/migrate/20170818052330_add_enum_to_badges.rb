class AddEnumToBadges < ActiveRecord::Migration
  def up
    change_column :badges, :name, 'integer USING CAST(name AS integer)'
  end

  def down
    change_column :badges, :name, :string
  end
end
