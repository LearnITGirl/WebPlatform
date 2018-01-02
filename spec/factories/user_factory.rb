FactoryBot.define do
	factory :user do
		email "robot@email.com"
		role 1
		first_name "Robot"
		last_name "Rspec"
		password "123456"
		password_confirmation "123456"
		edition_id 1
	end

	factory :mentee, class: User do
		email "mentee@email.com"
		role 2
		first_name "Mentee"
		last_name "Rspec"
		password "123456"
		password_confirmation "123456"
		edition_id 1
		mentee_application_id nil
	end

	factory :mentor, class: User do
		email "mentor@email.com"
		role 3
		first_name "Mentor"
		last_name "Rspec"
		password "123456"
		password_confirmation "123456"
		edition_id 1
	end

	factory :missing_mentee, class: User do
		email "mentee_missing@email.com"
		role 2
		first_name "Mentee"
		last_name "Missing"
		password "123456"
		password_confirmation "123456"
		edition_id 1
		is_missing false
	end

	factory :missing_mentor, class: User do
		email "mentor_missing@email.com"
		role 3
		first_name "Mentor"
		last_name "Missing"
		password "123456"
		password_confirmation "123456"
		edition_id 1
		is_missing false
	end
end