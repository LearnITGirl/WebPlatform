namespace :rematching_results do
  desc "mentees and mentors who have resigned"
  task resigned_users: :environment do
    email_templates = EmailTemplate.where(recipients: [25, 26])

    email_templates.each do |template|
      template.users.each do |user|
        EmailTemplateMailer.custom(template, user).deliver_now
      end
    end
  end

  desc "mentees and mentors whos partners resigned"
  task resigned_users_partners: :environment do
    email_templates = EmailTemplate.where(recipients: [27, 28])

    email_templates.each do |template|
      template.users.each do |user|
        EmailTemplateMailer.custom(template, user).deliver_now
      end
    end
  end

  desc "mentees and mentors who have been rematched"
  task rematched_users: :environment do
    email_templates = EmailTemplate.where(recipients: [29, 30, 31, 32])

    email_templates.each do |template|
      template.users.each do |user|
        EmailTemplateMailer.custom(template, user).deliver_now
      end
    end
  end
end
