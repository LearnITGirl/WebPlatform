namespace :mentee_results do
  desc "accepted mentees"
  task accepted: :environment do
    email_template = EmailTemplate.find_by(recipients: 0)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
      user.update_column :results_send_at, DateTime.now
    end
  end

  desc "waiting list mentees"
  task waiting: :environment do
    email_template = EmailTemplate.find_by(recipients: 12)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
      user.update_column :results_send_at, DateTime.now
    end
  end

  desc "rejected mentees"
  task rejected: :environment do
    email_template = EmailTemplate.find_by(recipients: 1)

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
      user.update_column :results_send_at, DateTime.now
    end
  end
end
