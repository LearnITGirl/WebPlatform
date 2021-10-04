module MentorApplicationsHelper

  def timezone_options
    ActiveSupport::TimeZone.all.sort.map do |zone|
      [zone.to_s, "#{timezone_to_offset_string(zone)} - #{zone.name}"]
    end
  end

  def timezone_to_offset_string(timezone)
    timezone.now.utc_offset / 3600
  end

  def available_engagements
  {
    hs_student: "I am a high school student", bc_student: "I am a bachelor student",
    master_student: "I am a master student", phd_student: "I am a PhD student",
    one_project: "I am working on at least one project", part_time: "I am working part-time",
    full_time: "I am working full-time", volunteer: "I am a volunteer"
  }
  end

  def time_availabilities
    {
      "1": "Under one hour per week",
      "2": "1-2 hours per week",
      "3": "3-5 hours per week",
      "4": "6-7 hours per week",
      "5": "8-10 hours per week"
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
      participant: "Last edition participant", wit: "Women in Technology Poland",
      gwcr: "Girls Who Code Romania", whc: "Women Who Code", py_ladies: "PyLadies",
      rails_girls: "Rails Girls", latinas_in_computing: "Latinas in Computing",
      indian_women: "Indian Women in Computing", litg_fb_page: "Learn IT, Girl facebook page",
      litg_fb_group: "Learn IT, Girl facebook group", litg_blog: "Learn IT, Girl blog",
      litg_twitter: "Learn IT, Girl twitter", litg_newsletter: "Learn IT, Girl newsletter",
      she_plus_plus: "She++", django_girls: "DjangoGirls",
      ghc_scholars_page: "GHC scholars page", ghc_indian_scholars: "GHC India scholars group",
      outreachy: "Outreachy", gnome_women: "Gnome Women", ununtu_women: "Ubuntu Women",
      linux_chix: "Linux Chix", comp_scisters: "CompScisters", lovelace: "Lovelace Alumnae mailing list"
    }
  end
end
