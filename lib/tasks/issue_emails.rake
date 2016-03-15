namespace :issue_emails do
  desc "TODO"
  task abandoned_mails_mentors: :environment do
    email_template = EmailTemplate.find_by(recipients: 6)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end

  end

  desc "TODO"
  task abandoned_mails_mentees: :environment do
    email_template = EmailTemplate.find_by(recipients: 7)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end

  end

end
