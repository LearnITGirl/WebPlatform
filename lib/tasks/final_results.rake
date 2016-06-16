namespace :final_results do

  desc "passed mentess"
  task passed_mentees: :environment do
    email_template = EmailTemplate.find_by(recipients: 23)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end
  end

  desc "rejected mentees"
  task rejected_mentees: :environment do
    email_template = EmailTemplate.find_by(recipients: 24)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end
  end

  desc "passed mentors"
  task passed_mentors: :environment do
    email_template = EmailTemplate.find_by(recipients: 21)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end
  end

  desc "rejected mentors"
  task rejected_mentors: :environment do
    email_template = EmailTemplate.find_by(recipients: 22)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end
  end
end
