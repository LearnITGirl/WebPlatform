namespace :cleanup do
  desc "removes stale and inactive applications from the database"
  task applications: :environment do
    stale_mentee_applications = MenteeApplication.where(created_at: (6.months.ago..(DateTime.now - 24.hours))).where.not(build_step: "done")
    stale_mentee_applications.map(&:destroy)

    stale_mentor_applications = MentorApplication.where(created_at: (6.months.ago..(DateTime.now - 24.hours))).where.not(build_step: "done")
    stale_mentor_applications.map(&:destroy)
  end

  task split_other: :environment do
    include MentorApplicationsHelper
    mentor_languages = MentorApplication.where(build_step: 'done').where.not(programming_languages: []).pluck(:programming_languages).flatten.group_by {|x| x }.map {|x, match| [x] }.flatten - MentorApplicationsHelper.available_languages.keys

    mentor_languages.each do |option|
      if option.split(',').length > 1
        MentorApplication.evaluated.where("? = ANY (programming_languages)", option).each do |app|
          app.programming_languages = app.programming_languages - [option] + option.split(',').map{|x| x.strip}
          app.save!
        end
      end
    end
  end

  task merge_lng: :environment do
    include MentorApplicationsHelper
    mentor_languages = MentorApplication.where(build_step: 'done').where.not(programming_languages: []).pluck(:programming_languages).flatten.group_by {|x| x }.map {|x, match| [x] }.flatten - MentorApplicationsHelper.available_languages.keys

    mentor_languages.each do |y|
      case y
      when "GNU/R", " R", "R"
        rename_mentor_language(y, "R")
      when "OBJECTIVE C", "Objective-C", "Objective C", "iOS"
        rename_mentor_language(y, "objective_c")
      when " Swift", "Swift"
        rename_mentor_language(y, "swift")
      when " Spring-Hibernate"
        rename_mentor_language(y, "java")
      when "AngularJS", "angular.js", "jQuery"
        rename_mentor_language(y, "javascript")
      when "Android ", "Android", "Java (Android)"
        rename_mentor_language(y, "android")
      when "Django framework"
        rename_mentor_language(y, "python")
      when "Ruby on Rails"
        rename_mentor_language(y, "ruby")
      end
    end

    mentee_lng = MenteeApplication.where(build_step: 'done').pluck(:programming_language).group_by {|x| x }.map {|x, match| [x] }.flatten - MentorApplicationsHelper.available_languages.keys

    mentee_lng.each do |z|
      case z
      when "iOs"
        MenteeApplication.where(programming_language: z).update_all(programming_language: "objective_c")
      when "Ruby on Rails"
        MenteeApplication.where(programming_language: z).update_all(programming_language: "ruby")
      when "on"
        MenteeApplication.where(programming_language: z).update_all(state: 3)
      when "Android"
        MenteeApplication.where(programming_language: z).update_all(programming_language: "android")
      when "javascript or python"
        MenteeApplication.where(programming_language: z).update_all(programming_language: "python")
      when "Vala and GTK+"
        MenteeApplication.where(programming_language: z).update_all(state: 3)
      when "HTML, CSS, Javascript."
        MenteeApplication.where(programming_language: z).update_all(programming_language: "html_css")
      when "I would like to learn several  languages Javascript, Ruby and Python"
        MenteeApplication.where(programming_language: z).update_all(programming_language: "ruby")
      when "HTML, CSS, JavaScript, (if need Python)"
        MenteeApplication.where(programming_language: z).update_all(programming_language: "html_css")
      when "swift, object C, java"
        MenteeApplication.where(programming_language: z).update_all(programming_language: "swift")
      when "Some HTML, CSS, and JavaScript"
        MenteeApplication.where(programming_language: z).update_all(programming_language: "html_css")
      end
    end
  end

  private

  def rename_mentor_language(language, new_language)
    app = MentorApplication.where("? = ANY (programming_languages)", language)
    app.each do |x|
      x.programming_languages = x.programming_languages - [language] + [new_language]
      x.save!
    end
  end
end
