FactoryBot.define do
	factory :edition do
		start_date DateTime.new(2018, 05, 01)
		end_date DateTime.new(2018, 11, 15)
		name "Edition 2018"
		registration_started_at DateTime.new(2017, 12, 01)
		registration_closed_at DateTime.new(2018, 04, 01)
	end
end