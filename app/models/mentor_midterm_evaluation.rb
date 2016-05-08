class MentorMidtermEvaluation < ActiveRecord::Base
  belongs_to :mentor, class_name: 'User', foreign_key: "mentor_id"

  validates :project_progress, :positive_aspects, :mentee_impression, :future_plans,
            :weekly_hours, presence: true
end
