module MenteeApplicationsHelper

  def mentee_other_language_value
    available_languages.keys.include?(@mentee.programming_language) ? nil : @mentee.programming_language
  end

  def other_value
    available_languages.keys.include?(@mentee.programming_language) ? "other" : @mentee.programming_language
  end

  def other_known_language_value
    other = @mentee.known_programming_languages.select{|a| !available_languages.keys.include?(a)}
    other.present? ? other.reject{|a| a == "other"} : nil
  end
end
