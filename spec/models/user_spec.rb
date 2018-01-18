require 'rails_helper'

RSpec.describe User, type: :model do
	describe 'model tests' do
		before(:each) do
			@user = create(:user)
			@edition = create(:edition)
			@mentee_application = create(:mentee_application)
			@mentor_application = create(:mentor_application)
			@mentor = create(:mentor)
			@mentee = create(:mentee, mentee_application_id: @mentee_application.id, last_activity_at: 20.days.ago)
			@mentee_midterm_evaluation = create(:simple_mentee_midterm_evaluation,
				mentee_id: @mentee.id)

			@final_survey = create(:simple_final_survey, mentor_id: @mentor.id,
				mentee_id: @mentee.id, edition_id: @edition.id)

			@project = create(:project, language: "ruby", mentor_id: @mentor.id,
				mentee_id: @mentee.id, edition_id: @edition.id)
		end

		it 'should get user full name' do
			full_name = @user.full_name
			expect(full_name).to eq('Robot Rspec')
		end

		it 'should check if user is an organizer' do
			expect(@user.organizer?).to be(true)
		end

		it 'should check if user is a mentee' do
			expect(@mentee.partner).to eq(@mentor)
		end

		it 'should get project with @mentee match' do
			expect(@mentee.matched_id).to be(@mentee.id)
		end

		it 'should get the midterm evaluation from mentee user' do
			expect(@mentee.midterm_self_evaluation).to eq(@mentee_midterm_evaluation)
		end

		it 'should get the final survey' do
			expect(@mentee.final_survey).to eq(@final_survey)
		end

		it 'should get mentee user application' do
			expect(@mentee.application).to eq(@mentee_application)
		end

	end
end