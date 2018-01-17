require 'rails_helper'

RSpec.describe Api::MentorApplicationsController, type: :controller do
  describe "Api Mentor Application controller tests" do
		before(:each) do
			@edition = create(:edition)
		end

		it 'should start to create a Mentor Application, step 1' do
			post :create, application: {
				first_name: "Mentor", last_name: "Rspec", email: "mentor@email.com",
				gender: "female", country: "IN", program_country: "IN",
				time_zone: "5 - Mumbai", english_level: nil,
				mentee_level: [], experienced: "false",
				mentor_experience: "Mentor Experience",
				old_programming_languages: [], programming_experience: nil,
				time_availability: 3,
				communicating_in_english: "true" },
				step: "1", steps: "5"

			expect(response).to have_http_status(200)
		end

		it 'should continue to create a Mentor Application, step 2' do
			post :create, application: {
				first_name: "Mentor", last_name: "Rspec", email: "mentor@email.com",
				motivation: "Motivation", background: "Background",
				gender: "female", country: "IN", program_country: "IN",
				time_zone: "5 - Mumbai", english_level: nil,
				mentee_level: [], experienced: "false",
				mentor_experience: "Mentor Experience",
				old_programming_languages: [], programming_experience: nil,
				time_availability: 3,
				communicating_in_english: "true" },
				step: "2", steps: "5"

			expect(response).to have_http_status(200)
		end

		it 'should continue to create a Mentor Application, step 3' do
			post :create, application: {
				first_name: "Mentor", last_name: "Rspec", email: "mentor@email.com",
				motivation: "Motivation", background: "Background",
				gender: "female", country: "IN", program_country: "IN",
				time_zone: "5 - Mumbai", english_level: nil,
				git: "true", operating_system: "linux",
				mentee_level: [], experienced: "false",
				mentor_experience: "Mentor Experience",
				old_programming_languages: [], programming_experience: nil,
				programming_languages: ["ruby", "php"],
				time_availability: 3,
				communicating_in_english: "true" },
				step: "3", steps: "5"

			expect(response).to have_http_status(200)
		end

		it 'should continue to create a Mentor Application, step 4' do
			post :create, application: {
				first_name: "Mentor", last_name: "Rspec", email: "mentor@email.com",
				motivation: "Motivation", background: "Background",
				gender: "female", country: "IN", program_country: "IN",
				time_zone: "5 - Mumbai", english_level: nil,
				git: "true", operating_system: "linux",
				mentee_level: [], experienced: "false",
				mentor_experience: "Mentor Experience",
				old_programming_languages: [], programming_experience: nil,
				programming_languages: ["ruby", "php"], application_idea: "Application Idea",
				concept_explanation: "Concept Explanation", time_availability: 3,
				communicating_in_english: "true" },
				step: "4", steps: "5"

			expect(response).to have_http_status(200)
		end

		it 'should not create a Mentor Application, step 5' do
			post :create, application: {
				first_name: "Mentor", last_name: "Rspec", email: "mentor@email.com",
				gender: "female", country: "IN", program_country: "IN",
				time_zone: "5 - Mumbai", motivation: "Motivation", english_level: nil,
				mentee_level: [], experienced: "false",
				mentor_experience: "Mentor Experience", background: "Background",
				git: "true", old_programming_languages: [], programming_experience: nil,
				application_idea: "Application Idea",
				communicating_in_english: "",
				concept_explanation: "Concept Explanation",
				time_availability: "",
				engagements: ["master_student", "part_time", "volunteer", "one_project"] },
				step: "5", steps: "5"

			expect(response).to have_http_status(:unprocessable_entity)
		end

		it 'should create a Mentor Application, step 5' do
			applications = MentorApplication.count
			post :create, application: {
				first_name: "Mentor", last_name: "Rspec", email: "mentor@email.com",
				gender: "female", country: "IN", program_country: "IN",
				time_zone: "5 - Mumbai", motivation: "Motivation", 
				communicating_in_english: "true", english_level: "",
				mentee_level: [], experienced: "false",
				mentor_experience: "Mentor Experience", background: "Background",
				git: "true", old_programming_languages: ["ruby", "php"], programming_experience: nil, programming_languages: ["ruby", "php"],
				application_idea: "Application Idea",
				concept_explanation: "Concept Explanation",
				time_availability: 3,
				engagements: ["master_student", "part_time", "volunteer", "one_project"] },
				step: "5", steps: "5"

			expect(response).to have_http_status(200)
			expect(MentorApplication.count).to eq(applications+1)
			expect(flash[:notice]).to eq("Thank you for your application!")
		end

  end
end
