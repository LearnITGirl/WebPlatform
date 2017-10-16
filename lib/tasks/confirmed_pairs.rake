namespace :confirmed_pairs do
  desc "mentees"
  task mentees: :environment do
    email_template = EmailTemplate.find_by(recipients: 19)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end
  end

  desc "mentors"
  task mentors: :environment do
    email_template = EmailTemplate.find_by(recipients: 20)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end
  end
end
