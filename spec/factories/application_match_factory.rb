FactoryBot.define do
	factory :application_match do
		mentor_application_id nil
		mentee_application_id nil
		confirmed false
		created_at DateTime.now
	end
end