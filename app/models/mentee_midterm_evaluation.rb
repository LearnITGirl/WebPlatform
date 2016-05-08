class MenteeMidtermEvaluation < ActiveRecord::Base
  belongs_to :mentee, class_name: 'User', foreign_key: "mentee_id"
  belongs_to :project, class_name: 'Project', foreign_key: "mentee_midterm_evaluation_id"

  validates :project_progress, :language_progress, :positive_aspects, :future_plans,
            :weekly_hours, :mentor_impression, presence: true
end
