FactoryBot.define do
	factory :application_match do
		mentor_application_id 1
		mentee_application_id 1
		confirmed false
		created_at DateTime.now
	end
end