namespace :registration_reminder do
  
  desc "send email reminder to unregistered mentors"
  task mentor_registration_reminder: :environment do
    email_template = EmailTemplate.find_by(recipients: 14)

    email_template.users.each do |user|
      binding.pry
      EmailTemplateMailer.custom(email_template, user).deliver
    end
  end

  desc "send email reminder to unregistered mentees"
  task mentee_registration_reminder: :environment do
    email_template = EmailTemplate.find_by(recipients: 13)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver
    end
  end

end
