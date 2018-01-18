FactoryBot.define do
	factory :task do
		title "Task 01 - Test Complete"
		creator_id nil
		created_at Date.today
		project_id nil
		week 1
		status nil
		finished_by nil
		deleted_at nil
		updated_at nil
		completed_at nil
	end
end