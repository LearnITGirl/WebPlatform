namespace :cleanup do
  desc "removes stale and inactive applications from the database"
  task applications: :environment do
    stale_mentee_applications = MenteeApplication.where(created_at: (6.months.ago..(DateTime.now - 24.hours))).where.not(build_step: "done")
    stale_mentee_applications.map(&:destroy)

    stale_mentor_applications = MentorApplication.where(created_at: (6.months.ago..(DateTime.now - 24.hours))).where.not(build_step: "done")
    stale_mentor_applications.map(&:destroy)
  end
end
