namespace :mentor_results do
  desc "accepted mentors"
  task accepted: :environment do
    email_template = EmailTemplate.find_by(recipients: 2)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
      user.update_column :results_send_at, DateTime.now
    end
  end

  desc "waiting list mentors"
  task waiting: :environment do
    email_template = EmailTemplate.find_by(recipients: 10)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
      user.update_column :results_send_at, DateTime.now
    end
  end

  desc "rejected mentors"
  task rejected: :environment do
    email_template = EmailTemplate.find_by(recipients: 11)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
      user.update_column :results_send_at, DateTime.now
    end
  end
end
