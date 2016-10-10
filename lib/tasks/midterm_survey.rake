namespace :midterm_survey do
  desc "survey for mentees"
  task mentees: :environment do
    email_template = EmailTemplate.find_by(recipients: 16)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end
  end

  desc "survey for mentors"
  task mentors: :environment do
    email_template = EmailTemplate.find_by(recipients: 15)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end
  end
end
