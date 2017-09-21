class MentorApplication < ActiveRecord::Base
  has_many :evaluations, dependent: :destroy
  has_and_belongs_to_many :programming_languages, uniq: true
  belongs_to :evaluator, class_name: 'User', foreign_key: "evaluator_id"
  belongs_to :edition

  enum time_availability: {below_1: 1, up_to_2: 2, up_to_5: 3, up_to_7: 4, up_to_10: 5}
  enum state: {pending: 1, skipped: 2, rejected: 3, evaluated: 4}

  scope :not_rejected, -> { where.not(state: 3).where.not(state: 'rejected') }
  scope :not_evaluated, -> { not_rejected.eager_load(:evaluations).where('evaluations IS NULL') }
  scope :evaluated, -> { not_rejected.eager_load(:evaluations).where.not('evaluations IS NULL') }

  scope :know_english, -> { where(communicating_in_english: true) }
  scope :have_time_to_learn, -> { where("time_availability >= ?", 2) }

  scope :pending, -> { where(state: 1) }
  scope :no_evaluator_assigned, -> { where(evaluator_id: nil) }

  before_save :set_edition

  def self.active
    pending.no_evaluator_assigned
  end

  def self.waiting_list
    evaluated.where("evaluations.score >= ?", 40)
      .where.not(id: ApplicationMatch.pluck(:mentor_application_id))
      .order("evaluations.score DESC")
  end

  def self.not_enough_points
    evaluated.where("evaluations.score < ?", 40)
  end

  def self.all_rejected_candidates
    rejected.where(results_send_at: nil) + not_enough_points.where(results_send_at: nil) + done.where(results_send_at: nil, state: [1, 2])
  end

  def self.left_for_evaluation
    active.not_evaluated.know_english.have_time_to_learn.count + skipped.count
  end

  def evaluation_score
    percentage = ((evaluations.sum(:score)/evaluations.size)/80)*100
    "#{percentage.to_f.round(1)}%"
  end

  def set_edition
    return if self.edition.present?
    self.edition = Edition.where(name: ENV["ACTUAL_EDITION"]).first
  end
end
