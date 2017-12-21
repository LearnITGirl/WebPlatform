FactoryBot.define do
	factory :user do
		email "robot@email.com"
		role 1
		first_name "Robot"
		password "123456"
		password_confirmation "123456"
	end
end