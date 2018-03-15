require 'rails_helper'

RSpec.describe Api::MentorApplicationsController, type: :controller do
  describe "Api Mentor Application controller tests" do
		let!(:edition) { create(:edition) }
		let(:params_step1) do { 
			first_name: "Mentor", last_name: "Rspec", email: "mentor@email.com",
			gender: "female", country: "IN", program_country: "IN",
			time_zone: "5 - Mumbai", english_level: nil,
			mentee_level: [], experienced: "false",
			mentor_experience: "Mentor Experience",
			old_programming_languages: [], programming_experience: nil,
			time_availability: "", communicating_in_english: "true", }
		end
		let(:params_step2) do
			params_step1.merge({
				motivation: "Motivation", background: "Background", })
		end
		let(:params_step3) do
			params_step2.merge({
				git: "true", operating_system: "linux",
				programming_languages: ["ruby", "php"], })
		end
		let(:params_step4) do
			params_step3.merge({
				application_idea: "Application Idea", 
				concept_explanation: "Concept Explanation", })
		end
		let(:params_step5) do
			params_step4.merge({
				engagements: ["master_student", "part_time", "volunteer", "one_project"], })
		end

		it 'should start to create a Mentor Application, step 1' do
			post :create, application: params_step1,
				step: "1", steps: "5"

			expect(response).to have_http_status(200)
		end

		it 'should continue to create a Mentor Application, step 2' do
			post :create, application: params_step2,
				step: "2", steps: "5"

			expect(response).to have_http_status(200)
		end

		it 'should continue to create a Mentor Application, step 3' do
			post :create, application: params_step3,
				step: "3", steps: "5"

			expect(response).to have_http_status(200)
		end

		it 'should continue to create a Mentor Application, step 4' do
			post :create, application: params_step4,
				step: "4", steps: "5"

			expect(response).to have_http_status(200)
		end

		it 'should not create a Mentor Application, step 5' do
			post :create, application: params_step5,
				step: "5", steps: "5"

			expect(response).to have_http_status(:unprocessable_entity)
		end

		it 'should create a Mentor Application, step 5' do
			applications = MentorApplication.count
			final_params = params_step5.merge({ time_availability: 3, })
			post :create, application: final_params,
				step: "5", steps: "5"

			expect(response).to have_http_status(200)
			expect(MentorApplication.count).to eq(applications+1)
			expect(flash[:notice]).to eq("Thank you for your application!")
		end

  end
end
