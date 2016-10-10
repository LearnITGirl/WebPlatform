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

  desc "send warning emails to mentees who did not use app for two weeks"
  task mentee_missing_from_website_warning: :environment do
    mentee_email_template = EmailTemplate.find_by(recipients: 15)

    mentee_email_template.users.each do |mentee|
      EmailTemplateMailer.custom(mentee_email_template, mentee).deliver_now
    end
  end

  desc "send warning emails to mentors who did not use app for two weeks"
  task mentor_missing_from_website_warning: :environment do
    mentor_email_template = EmailTemplate.find_by(recipients: 16)

    mentor_email_template.users.each do |mentor|
      EmailTemplateMailer.custom(mentor_email_template, mentor).deliver_now
    end
  end

end
