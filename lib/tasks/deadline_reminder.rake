namespace :deadline_reminder do

  desc "send email reminder to mentors and mentees who did not decide on the project after first week"
  task project_setup_reminder: :environment do
    users_missing_project_setup = Project.get_users_missing_project_setup
    users_missing_project_setup.each do |user|
    	if user.mentor?
    		MissingProjectSetupMailer.mentor_missing_project_setup(user).deliver
    	else
    		MissingProjectSetupMailer.mentee_missing_project_setup(user).deliver
    	end
    end
  end

end
