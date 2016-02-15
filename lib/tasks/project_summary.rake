namespace :project_summary do

  desc "send daily summary of projects to registered users"
  task daily_project_summary: :environment do
       @users = User.where(role: [2,3])
       @users.each do |user|
          ProjectSummaryMailer.project_summary(user).deliver
       end
  end

end
