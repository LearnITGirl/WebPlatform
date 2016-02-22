namespace :deadline_reminder do

  desc "send email reminder to mentors and mentees who did not decide on the project after first week"
  task project_setup_reminder: :environment do
    mentees_email_template = EmailTemplate.find_by(recipients: 15)
    mentors_email_template = EmailTemplate.find_by(recipients: 16)
    mentees_email_template.users.each do |mentee|
      EmailTemplateMailer.custom(mentees_email_template, mentee).deliver_now
    end
    mentors_email_template.users.each do |mentor|
      EmailTemplateMailer.custom(mentors_email_template, mentor).deliver_now
    end
  end

end
