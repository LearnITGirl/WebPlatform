class MentorApplication < ActiveRecord::Base
  has_many :evaluations, dependent: :destroy
  belongs_to :evaluator, class_name: 'User', foreign_key: "evaluator_id"

  validates :first_name, :last_name, :email, :gender, :country, :program_country,
            :time_zone, presence: true, on: :update, if: :done_or_personal_information?

  validates :motivation, :english_level, :mentee_level,
            :mentor_experience, presence: true, on: :update, if: :done_or_experience?

  validates :background, :programming_languages, :programming_experience,
            presence: true, on: :update, if: :done_or_programming_experience?

  validates :email, format: { with: REGEXP_EMAIL }, on: :update, if: :done_or_personal_information?

  validate :already_applied, on: :update, if: :done_or_personal_information?

  validate :other_language, on: :update, if: "done_or_programming_experience?"

  validates :sources, :engagements, :time_availability, :application_idea, :concept_explanation,
            presence: true, on: :update, if: :done_or_details?

  enum time_availability: {below_1: 1, up_to_2: 2, up_to_5: 3, up_to_7: 4, up_to_10: 5}
  enum state: {pending: 1, skipped: 2, rejected: 3, evaluated: 4}

  scope :done, -> { where(build_step: 'done') }
  scope :not_rejected, -> { where.not(state: 3).where.not(state: 'rejected') }
  scope :not_evaluated, -> { done.not_rejected.eager_load(:evaluations).where('evaluations IS NULL') }
  scope :evaluated, -> { done.not_rejected.eager_load(:evaluations).where.not('evaluations IS NULL') }

  scope :know_english, -> { where.not(english_level: 'not so well').where.not(english_level: nil) }
  scope :have_time_to_learn, -> { where("time_availability >= ?", 2) }

  scope :pending, -> { where(state: 1) }
  scope :no_evaluator_assigned, -> { where(evaluator_id: nil) }

  def self.active
    pending.no_evaluator_assigned
  end

  def done?
    build_step.to_s == "done"
  end

  def done_or_personal_information?
    build_step.to_s == "personal_information" || done?
  end

  def done_or_experience?
    build_step.to_s == "experience" || done?
  end

  def done_or_programming_experience?
    build_step.to_s == "programming_experience" || done?
  end

  def done_or_details?
    build_step.to_s == "details" || done?
  end

  def evaluation_score
    percentage = ((evaluations.sum(:score)/evaluations.size)/80)*100
    "#{percentage.to_f.round(1)}%"
  end

  private

  def other_language
    if programming_languages && programming_languages.include?("other") && other_programming_language.blank?
      errors.add(:other_programming_language, "can't be blank")
    end
  end

  def already_applied
    if MentorApplication.where(email: email, build_step: "done").where.not(id: id).present?
      errors.add(:base, "You already applied to be a mentor")
    elsif MenteeApplication.where(email: email, build_step: "done").where.not(id: id).present?
      errors.add(:base, "You can only apply once to the program and you already applied to be a mentee.")
    end
  end
end
