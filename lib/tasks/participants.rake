namespace :participants do

  desc "Send email with latest info to mentees"
  task mentee_latest_info: :environment do
    template = EmailTemplate.final_mentees.last

    template.users.each do |user|
      EmailTemplateMailer.custom(template, user).deliver_now
    end
  end

  desc "Send email with latest info to mentors"
  task mentor_latest_info: :environment do
    template = EmailTemplate.final_mentors.last

    template.users.each do |user|
      EmailTemplateMailer.custom(template, user).deliver_now
    end
  end
end
