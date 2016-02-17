namespace :project_summary do

  desc "send daily summary of projects to registered users"
  task daily_project_summary: :environment do
    date = DateTime.now

    if date.wday == 1
      @users = User.where(role: [2,3])
      @users.each do |user|
        next if user.last_week_tasks(date.last_week).empty?
        ProjectSummaryMailer.project_summary(user, date.last_week).deliver_now
      end
    end
  end
end
