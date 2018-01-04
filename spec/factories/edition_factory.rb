FactoryBot.define do
	factory :edition do
		start_date DateTime.new(2018, 8, 1)
		end_date DateTime.new(2019, 2, 15)
		name "Edition 2018"
		registration_started_at DateTime.new(2017, 12, 1)
		registration_closed_at DateTime.new(2018, 7, 1)
	end
end