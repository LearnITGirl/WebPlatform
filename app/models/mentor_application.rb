class MentorApplication < ActiveRecord::Base
  has_many :evaluations

  validates :first_name, :last_name, :email, :gender, :country, :program_country,
            :time_zone, presence: true, on: :update, if: :done_or_personal_information?

  validates :motivation, :english_level, :mentee_level,
            :mentor_experience, presence: true, on: :update, if: :done_or_experience?

  validates :background, :programming_languages, :programming_experience,
            presence: true, on: :update, if: :done_or_programming_experience?

  validates :email, format: { with: REGEXP_EMAIL }, on: :update, if: :done_or_personal_information?

  validate :already_applied, on: :update, if: :done_or_personal_information?

  validate :other_language, on: :update, if: :done_or_programming_experience?

  validates :sources, :engagements, :time_availability, :application_idea, :concept_explanation,
            presence: true, on: :update, if: :done_or_details?

  enum time_availability: {below_1: 1, up_to_2: 2, up_to_5: 3, up_to_7: 4, up_to_10: 5}

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
    evaluations.map(&:score).sum / evaluations.size
  end

  def self.no_evaluation
    MentorApplication.joins("LEFT JOIN evaluations ON mentor_applications.id = evaluations.mentor_application_id").
      where("evaluations.mentor_application_id is null")
  end

  private

  def other_language
    if programming_languages && programming_languages.include?(nil) || programming_languages.include?("")
      errors.add(:other_programming_language, "can't be blank")
    end
  end

  def already_applied
    if MentorApplication.where(email: email).where.not(id: id).present?
      errors.add(:base, "You already applied to be a mentor")
    end
  end
end
