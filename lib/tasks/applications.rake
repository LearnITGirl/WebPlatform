namespace :applications do
  task send_outstanding_confirmation_emails: :environment do
    MentorApplication.where(confirmation_email_sent_at: nil).each do |application|
      if MentorApplicationMailer.confirm_application(application).deliver_now
        application.update_attributes(confirmation_email_sent_at: Time.now)
      end
    end

    MenteeApplication.where(confirmation_email_sent_at: nil).each do |application|
      if MenteeApplicationMailer.confirm_application(application).deliver_now
        application.update_attributes(confirmation_email_sent_at: Time.now)
      end
    end
  end

  task handle_programming_languages_modification: :environment do
    MentorApplication.where.not(old_programming_languages: nil).each do |application|
      application[:old_programming_languages].each do |opl|
        pl = ProgrammingLanguage.where(slug: opl).first
        application.programming_languages << pl if pl.present?
      end
    end
    MenteeApplication.where.not(old_programming_language: nil).each do |application|
      application.programming_language = ProgrammingLanguage.where(slug: application[:old_programming_language]).first
      application.save
    end
  end
end
