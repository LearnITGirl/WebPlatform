namespace :participants do

  desc "Send email with latest info to passing mentees"
  task passing_mentee_latest_info: :environment do
    template = EmailTemplate.final_passing_mentees.last

    template.users.each do |user|
      EmailTemplateMailer.custom(template, user).deliver_now
    end
  end

  desc "Send email with latest info to passing mentors"
  task passing_mentor_latest_info: :environment do
    template = EmailTemplate.final_passing_mentors.last

    template.users.each do |user|
      EmailTemplateMailer.custom(template, user).deliver_now
    end
  end
end
