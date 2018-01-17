require 'rails_helper'

RSpec.describe MentorToMenteeMatchersController, type: :controller do
	describe 'Mentor to Mentee Matcher' do
		before(:each) do
			@edition = create(:edition)
			@organiser = create(:user)
			@mentee_application = create(:mentee_application)
			@mentor_application = create(:mentor_application)
			login_user(@organiser)
		end

		it 'should got to index matchers page' do
			get :index
			expect(response).to have_http_status(200)
		end

	end
end