require 'rails_helper'

RSpec.describe Api::MenteeApplicationsController, type: :controller do
	describe "Api Mentee Application controller tests" do
		let!(:edition) { create(:edition) }
		let(:params_step1) do {
			first_name: "Mentee", last_name: "Rspec", email: "mentee@email.com",
			gender: "female", country: "IN", program_country: "IN",
			time_zone: "5 - Mumbai", communicating_in_english: "true",
			send_to_mentor_confirmed: "true",
			time_availability: 3,
			previous_programming_experience: "false", }
		end
		let(:params_step2) do
			params_step1.merge({
				motivation: "Motivation", background: "Background",
				team_work_experience: "Team Work Experience", })
		end
		let(:params_step3) do
			params_step2.merge({
				experience: "", operating_system: "mac_os",
				project_proposal: "Project Proposal", roadmap: "Roadmap",
				engagements: ["master_student", "part_time", "volunteer", "one_project"], })
		end

		it 'should start create a Mentee Application, step 1' do
			post :create, application: params_step1,
				step: "1", steps: "3"

			expect(response).to have_http_status(200)
		end

		it 'should continue to create a Mentee Application, step 2' do
			post :create, application: params_step2,
				step: "2", steps: "3"

			expect(response).to have_http_status(200)
		end

		it 'should not create a Mentee Application in api format' do
			applications = MenteeApplication.count
			post :create, application: params_step3,
			step: "3", steps: "3"

			expect(response).to have_http_status(:unprocessable_entity)
			expect(MenteeApplication.count).to be(0)
		end

		it 'should create a Mentee Application in api format (step 3)' do
			applications = MenteeApplication.count
			params_final = params_step3.merge({ programming_language: "ruby", })
			post :create, application: params_final,
			step: "3", steps: "3"
			
			expect(response).to have_http_status(200)
			expect(MenteeApplication.count).to be(applications+1)
			expect(flash[:notice]).to eq("Thank you for your application!")
		end

	end
end
