require 'rails_helper'

RSpec.describe Api::MenteeApplicationsController, type: :controller do
	describe "Api Mentee Application controller tests" do
		before(:each) do
			@edition = create(:edition)
		end

		it 'should start create a Mentee Application, step 1' do
			post :create, application: {
				first_name: "Mentee", last_name: "Rspec", email: "mentee@email.com",
				gender: "female", country: "IN", program_country: "IN",
				time_zone: "5 - Mumbai", communicating_in_english: "true",
				send_to_mentor_confirmed: "true",
				time_availability: 3,
				previous_programming_experience: "false" },
				step: "1", steps: "3"

			expect(response).to have_http_status(200)
		end

		it 'should continue to create a Mentee Application, step 2' do
			post :create, application: {
				first_name: "Mentee", last_name: "Rspec", email: "mentee@email.com",
				gender: "female", country: "IN", program_country: "IN",
				time_zone: "5 - Mumbai", communicating_in_english: "true",
				send_to_mentor_confirmed: "true",
				time_availability: 3,
				motivation: "Motivation",
				background: "Background",
				team_work_experience: "Team Work Experience",
				previous_programming_experience: "false" },
				step: "2", steps: "3"

			expect(response).to have_http_status(200)
		end

		it 'should not create a Mentee Application in api format' do
			applications = MenteeApplication.count
			post :create, application: {
				first_name: "Mentee", last_name: "Rspec", email: "mentee@email.com",
				gender: "female", country: "IN", program_country: "IN",
				time_zone: "5 - Mumbai", communicating_in_english: "true",
				send_to_mentor_confirmed: "true",
				motivation: "Motivation",
				background: "Background",
				team_work_experience: "Team Work Experience",
				previous_programming_experience: "false", experience: "",
				operating_system: "mac_os",
				project_proposal: "Project Proposal",
				roadmap: "Roadmap",
				time_availability: 3,
				engagements: ["master_student", "part_time", "volunteer", "one_project"] },step: "3", steps: "3"

			expect(response).to have_http_status(:unprocessable_entity)
			expect(MenteeApplication.count).to be(0)
		end

		it 'should create a Mentee Application in api format (step 3)' do
			applications = MenteeApplication.count
			post :create, application: {
				first_name: "Mentee", last_name: "Rspec", email: "mentee@email.com",
				gender: "female", country: "IN", program_country: "IN",
				time_zone: "5 - Mumbai", communicating_in_english: "true",
				send_to_mentor_confirmed: "true",
				motivation: "Motivation",
				background: "Background",
				programming_language: "ruby",
				team_work_experience: "Team Work Experience",
				previous_programming_experience: "false", experience: "",
				operating_system: "mac_os",
				project_proposal: "Project Proposal",
				roadmap: "Roadmap",
				time_availability: 3,
				engagements: ["master_student", "part_time", "volunteer", "one_project"] },step: "3", steps: "3"
			
			expect(response).to have_http_status(200)
			expect(MenteeApplication.count).to be(applications+1)
			expect(flash[:notice]).to eq("Thank you for your application!")
		end

	end
end