FactoryBot.define do
	factory :mentor_application do
		first_name "Test"
		last_name "Robot"
		email "mentor@litg.com"
		gender "male"
		country "BR"
		program_country "BR"
		time_zone "-2 - Brasilia"
		motivation "I want to help someone"
		mentee_level []
		experienced false
		mentor_experience "Some times I helped my economic professor."
		background "I am at university but already with 3 years of software development experience."
		git true
		application_idea "A complete profile web page."
		concept_explanation "The idea behind of Http requests I made a course to understand more about it."
		time_availability 3
		engagements ["bc_student" "one_project"]
		other_programming_language nil
		state 1
		communicating_in_english true
		operating_system "linux"
		edition_id 1
	end
end