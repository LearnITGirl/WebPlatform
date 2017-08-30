class Badge < ActiveRecord::Base
  has_many :assigned_badges
  has_many :users, through: :assigned_badges

  enum name: {
    midterm_survey: 1, final_survey: 2, blogger: 3,
    organized: 4, ambitious: 5, energetic: 6,
    timekeeper: 7, novice: 8, perfectionist: 9,
    coder: 10, visionary: 11
  }
end
