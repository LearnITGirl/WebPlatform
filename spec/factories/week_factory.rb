FactoryBot.define do

	factory :week1, class: Week do
		number 1
		start 14.months.from_now
		# end (14.months.from_now + 7.days)
		edition nil
	end

	factory :week2, class: Week do
		number 2
		start (14.months.from_now + 8.days)
		# end (14.months.from_now + 15.days)
		edition nil
	end

	factory :week3, class: Week do
		number 3
		start (14.months.from_now + 16.days)
		# end (14.months.from_now + 23.days)
		edition nil
	end

	factory :week4, class: Week do
		number 4
		start (14.months.from_now + 24.days)
		# end (14.months.from_now + 31.days)
		edition nil
	end

	factory :week5, class: Week do
		number 5
		start (14.months.from_now + 32.days)
		# end (14.months.from_now + 39.days)
		edition nil
	end

end