class Mentor < ActiveRecord::Base

  validates :first_name, :last_name, :email, :gender, :country, :program_country,
            :time_zone, presence: true, on: :update, if: :done_or_personal_information?

  validates :motivation, :english_level, :mentee_level,
            :mentor_experience, presence: true, on: :update, if: :done_or_experience?

  validates :background, :programming_languages, :git, :programming_experience,
            presence: true, on: :update, if: :done_or_programming_experience?

  validates :email, format: { with: REGEXP_EMAIL }, on: :update, if: :done_or_personal_information?

  validate :other_language, on: :update, if: :done_or_programming_experience?

  AVAILABLE_LANGUAGES = {
    "c" => "C", "c_plus_plus" => "C++", "java" => "Java", "python" => "Python",
    "c_sharp" => "C#", "dot_net" => ".NET", "html_css" => "HTML, CSS",
    "javascript" => "JavaScript", "ruby" => "Ruby", "php" => "PHP"
  }

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

  private

  def other_language
    if programming_languages && programming_languages.include?(nil) || programming_languages.include?("")
      errors.add(:other_programming_language, "can't be blank")
    end
  end
end
