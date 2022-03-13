class ChangeLikeMentoringBeginnerDefaultValue < ActiveRecord::Migration[6.1]
  def up
    change_column_default(:mentor_applications, :like_mentoring_beginner, nil)
  end

  def down
    change_column_default(:mentor_applications, :like_mentoring_beginner, false)
  end
end