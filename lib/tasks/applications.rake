namespace :applications do
  task handle_programming_languages_modification: :environment do
    MentorApplication.where.not(old_programming_languages: nil).each do |application|
      application[:old_programming_languages].each do |opl|
        pl = ProgrammingLanguage.where(slug: opl).first
        application.programming_languages << pl if pl.present?
      end
    end
    MenteeApplication.where.not(old_programming_language: nil).each do |application|
      application.programming_language = ProgrammingLanguage.where(slug: application[:old_programming_language]).first
    end
  end
end
