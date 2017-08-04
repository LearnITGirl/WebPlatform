Fabricator(:mentor_application) do
  first_name { Faker::Name.first_name}
  last_name { Faker::Name.last_name}
  email { Faker::Internet.email }
  gender { ['male', 'female'].sample }
  country { Faker::Address.country_code }
  program_country { Faker::Address.country_code }
  time_zone { ActiveSupport::TimeZone.all.sample.now.utc_offset / 3600 }
  motivation { Faker::StarWars.quote }
  mentor_experience { Faker::Hobbit.thorins_company }
  git { [true, false].sample }
  operating_system { ['windows', 'linux', 'mac_os'].sample }
  application_idea { Faker::StarWars.wookiee_sentence }
  concept_explanation { Faker::Witcher.quote }
  time_availability { MenteeApplication.time_availabilities.values.sample }
  communicating_in_english { [true, false].sample }
  edition_id { Edition.last.id }
  background { Faker::Simpsons.quote }

  programming_languages { [ProgrammingLanguage.all.sample] }
end

Fabricator(:mentor_pending_application, from: :mentor_application) do
  state { 'pending' }
end
