FactoryBot.define do
	factory :simple_final_survey, class: FinalSurvey do
		edition_id 1
		mentor_id 1
		mentee_id 1
		project_id nil
		mentee_impression nil
		mentor_impression nil
		mentee_expectations nil
		mentor_expectations nil
		mentee_project_summary nil
		mentor_project_summary nil
		mentee_feedback nil
		mentor_feedback nil
		mentee_future_plans nil
		mentee_program_duration nil
		mentor_program_duration nil
	end
end