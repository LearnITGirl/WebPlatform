FactoryBot.define do
	factory :simple_final_survey, class: FinalSurvey do
		edition_id nil
		mentor_id nil
		mentee_id nil
		project_id nil
		mentor_impression nil
		mentor_expectations nil
		mentor_project_summary nil
		mentor_feedback nil
		mentor_program_duration nil
	end
end