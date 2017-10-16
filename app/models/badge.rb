class Badge < ActiveRecord::Base
  has_many :assigned_badges
  has_many :users, through: :assigned_badges

  enum name: {
    midterm_survey: 1, final_survey: 2,
    organized: 3, ambitious: 4, energetic: 5,
    timekeeper: 6, novice: 7, perfectionist: 8,
    coder: 9, visionary: 10
  }
end
