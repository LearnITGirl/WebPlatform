FactoryBot.define do
  factory :edition do
    start_date 14.months.from_now
    end_date (14.months.from_now + 39.days)
    name "Edition 2018"
    registration_started_at DateTime.now
    registration_closed_at 1.year.from_now
  end
end