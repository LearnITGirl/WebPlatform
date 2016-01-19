class MenteeApplication < ActiveRecord::Base
  has_many :evaluations

  validates :first_name, :last_name, :email, :gender, :country, :program_country,
            :time_zone, presence: true, on: :update, if: :done_or_personal_information?

  validates :motivation, :english_level, :experience, presence: true,
            on: :update, if: :done_or_experience?

  validates :background, :programming_language, :programming_level, :project_proposal,
            :roadmap, presence: true, on: :update, if: :done_or_programming_experience?

  validates :email, format: { with: REGEXP_EMAIL }, on: :update, if: :done_or_personal_information?

  validate :already_applied, on: :update, if: :done_or_personal_information?
  validates :programming_experience, :known_programming_languages, on: :update,
            presence: true, if: :medium_mentee

  validate :other_known_language, on: :update, if: :medium_mentee
  validate :other_language, on: :update, if: "done_or_programming_experience?"

  validates :sources, :engagements, :time_availability, presence: true, on: :update,
            if: :done_or_details?

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

  private

  def medium_mentee
    done_or_programming_experience? && programming_level.present? && programming_level != "beginner"
  end

  def other_known_language
    if known_programming_languages && known_programming_languages.include?("other") && other_known_programming_language.blank?
      errors.add(:other_known_programming_language, "can't be blank")
    end
  end

  def other_language
    if programming_language == "other" && other_programming_language.blank?
      errors.add(:other_programming_language, "can't be blank")
    end
  end

  def already_applied
    if MenteeApplication.where(email: email, build_step: "done").where.not(id: id).present?
      errors.add(:base, "You already applied to be a mentee")
    elsif MentorApplication.where(email: email, build_step: "done").where.not(id: id).present?
      errors.add(:base, "You can only apply once to the program and you already applied to be a mentor.")
    end
  end
end
