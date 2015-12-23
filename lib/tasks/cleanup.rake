namespace :cleanup do
  desc "removes stale and inactive applications from the database"
  task applications: :environment do
    stale_mentee_applications = MenteeApplication.where("DATE(created_at) < DATE(?)", Date.yesterday).where.not(build_step: "done")
    stale_mentee_applications.map(&:destroy)

    stale_mentor_applications = MentorApplication.where("DATE(created_at) < DATE(?)", Date.yesterday).where.not(build_step: "done")
    stale_mentor_applications.map(&:destroy)
  end
end
