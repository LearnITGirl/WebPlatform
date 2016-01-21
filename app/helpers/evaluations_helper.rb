module EvaluationsHelper

  def eng_level(level)
    case level
    when "very well" then "Very well"
    when "not so well" then "Not so well"
    when "good enough" then "Good enough"
    when "no" then "No"
    end
  end

  def programming_level(level)
    case level
    when "beginner" then "I'm just learning to code"
    when "medium" then "I can code in at least one programming language but I'm not very confident in my skills"
    when "advanced" then "I am very confident about coding in at least one programming language"
    end
  end

  def known_languages(languages)
    languages.map do |lang|
      available_languages.key?(lang) ? available_languages[lang] : lang
    end.join(", ")
  end

  def mentee_level(level)
    level.map do |lvl|
      lvl == "beginners" ? "Absolute beginners" : "Women who already know a language and would like to learn another"
    end.join(" & ")
  end
end
