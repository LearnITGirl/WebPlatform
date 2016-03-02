class SetIsMissingAsFalseByDefault < ActiveRecord::Migration

  def change
    change_column :users, :is_missing, :boolean, default: false

    User.all.where(is_missing: nil).update_all(is_missing: false)
  end
end
