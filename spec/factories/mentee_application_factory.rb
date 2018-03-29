FactoryBot.define do
  factory :mentee_application do
    first_name "Mentee"
    last_name "Rspec"
    email "mentee@email.com"
    gender "female"
    country "IN"
    program_country "IN"
    time_zone "5 - Mumbai"
    motivation "Motivation - Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te."
    experience "Experience - Has an aliquip equidem."
    background "Background - Est quaerendum accommodare eu, erant recusabo his id, alterum partiendo et mel."
    project_proposal "Project Proposal - Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te."
    roadmap "Roadmap - Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te."
    time_availability 3
    engagements ["master_student", "part_time", "volunteer", "one_project"]
    state 1
    communicating_in_english true
    operating_system "mac_os"
    team_work_experience "Team Work Experience - Lorem ipsum dolor sit amet, malis zril accusam ex quo."
    previous_programming_experience true
    programming_language_id 9
    edition_id 1
  end
end