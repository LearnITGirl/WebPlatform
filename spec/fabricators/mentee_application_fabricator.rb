Fabricator(:mentee_application) do
  first_name { Faker::Name.first_name}
  last_name { Faker::Name.last_name}
  email { Faker::Internet.email }
  gender { ['male', 'female'].sample }
  country { Faker::Address.country_code }
  program_country { Faker::Address.country_code }
  time_zone { ActiveSupport::TimeZone.all.sample.now.utc_offset / 3600 }
  motivation { Faker::StarWars.quote }
  experience { Faker::Witcher.quote }
  background { Faker::Simpsons.quote }
  project_proposal { Faker::StarWars.wookiee_sentence }
  roadmap { Faker::Hobbit.quote }
  time_availability { MenteeApplication.time_availabilities.values.sample }
  communicating_in_english { [true, false].sample }
  operating_system { ['windows', 'linux', 'mac_os'].sample }
  team_work_experience { Faker::Hobbit.thorins_company }
  previous_programming_experience { [true, false].sample }
  edition { Edition.last }
  programming_language_id { ProgrammingLanguage.pluck(:id).sample }
end

Fabricator(:mentee_pending_application, from: :mentee_application) do
  state { 'pending' }
end
