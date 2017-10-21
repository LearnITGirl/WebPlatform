namespace :after_rematch_info do

  desc "inform mentees from waiting list they didn't get in - send after rematching is done"
  task waiting_list_mentees: :environment do
    email_template = EmailTemplate.mentees_on_waiting_list.last

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end
  end

  desc "inform mentors from waiting list they didn't get in - send after rematching is done"
  task waiting_list_mentors: :environment do
    email_template = EmailTemplate.mentors_on_waiting_list.last

    email_template.users.each do |user|
      EmailTemplateMailer.custom(email_template, user).deliver_now
    end
  end
end
