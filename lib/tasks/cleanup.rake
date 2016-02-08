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
    x = MentorApplication.where(build_step: 'done').where.not(programming_languages: []).pluck(:programming_languages).flatten.group_by {|x| x }.map {|x, match| [x] }.flatten - MentorApplicationsHelper.available_languages.keys

    x.each do |option|
      if option.split(',').length > 1
        MentorApplication.evaluated.where("? = ANY (programming_languages)", option).each do |app|
          app.programming_languages = app.programming_languages - [option] + option.split(',').map{|x| x.strip}
          app.save!
        end
      end
    end
  end

  task merge_lng: :environment do
    z = MenteeApplication.where(build_step: 'done').pluck(:programming_language).group_by {|x| x }.map {|x, match| [x, match.count] }
    x = MentorApplication.where(build_step: 'done').where.not(programming_languages: []).pluck(:programming_languages).flatten.group_by {|x| x }.map {|x, match| [x] }.flatten - MentorApplicationsHelper.available_languages.keys

    x.each do |y|
      y = y.downcase
    end
  end
end
