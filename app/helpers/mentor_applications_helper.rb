module MentorApplicationsHelper

  def timezone_options
    ActiveSupport::TimeZone.all.sort.map do |zone|
      [zone.to_s, "#{timezone_to_offset_string(zone)} - #{zone.name}"]
    end
  end

  def timezone_to_offset_string(timezone)
    timezone.now.utc_offset / 3600
  end

  def other_language_value
    other = @mentor.programming_languages.select{|a| !available_languages.keys.include?(a)}
    other.present? ? other.reject{|a| a == "other"} : nil
  end

  def available_engagements
  {
    hs_student: "I am a high school student", bc_student: "I am a bachelor student",
    master_student: "I am a master student", phd_student: "I am a PhD student",
    one_project: "I am working on at least one project", part_time: "I am working part-time",
    full_time: "I am working full time", volunteer: "I am a volunteer"
  }
  end

  def available_languages
    {
      "c" => "C", "c_plus_plus" => "C++", "java" => "Java", "python" => "Python",
      "c_sharp" => "C#", "dot_net" => ".NET", "html_css" => "HTML, CSS",
      "javascript" => "JavaScript", "ruby" => "Ruby", "php" => "PHP"
    }
  end

  def program_sources
    {
      friend: "A friend", organizer: "One of the organizers", press: "Local/national press",
      tv: "TV", gwcrfp: "Girls Who Code Romania Facebook page",
      gwcrfg: "Girls Who Code Romania Facebook group", ggc: "Geek Girls Carrot",
      geekettes: "Geekettes Facebook Group", gr8ladies: "Gr8Ladies", systers: "Systers",
      participant: "Last edition participant"
    }
  end
end
