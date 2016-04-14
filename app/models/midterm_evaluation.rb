class MidtermEvaluation < ActiveRecord::Base
  belongs_to :project

  scope :not_evaluated, -> { where(how_the_monitoring_process_works_for_mentor: nil) }

  def evaluated?
    self.how_the_monitoring_process_works_for_mentor.present? &&
    self.other_comments_from_the_mentor.present? &&
    self.how_the_monitoring_process_works_for_mentee.present? &&
    self.other_comments_from_the_mentee.present? &&
    self.mentor_description_of_the_work.present? &&
    self.what_the_mentee_has_done_so_far.present? &&
    self.technologies_and_environment.present? &&
    self.three_positive_aspects.present? &&
    self.what_the_mentor_thinks_the_mentee_did_well.present? &&
    self.three_things_the_mentee_plans_to_do_better.present? &&
    self.what_the_mentor_plans_to_work_on.present? &&
    self.hours_per_week_for_mentee.present? &&
    self.hours_per_week_for_mentor.present? &&
    self.mentor_evaluation.present? &&
    self.mentee_evaluation.present? &&
    self.mentees_project_status.present? &&
    self.github_repository_status.present?
  end
end

