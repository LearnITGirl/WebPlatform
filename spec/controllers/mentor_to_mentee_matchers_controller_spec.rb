require 'rails_helper'

RSpec.describe MentorToMenteeMatchersController, type: :controller do
	describe 'Mentor to Mentee Matcher' do
		let!(:edition) { create(:edition) }
		let(:organiser) { create(:user) }
		let(:mentee_application) { create(:mentee_application) }
		let(:mentor_application) { create(:mentor_application) }
		
		before(:each) do
			login_user(organiser)
		end

		it 'should got to index matchers page' do
			get :index
			expect(response).to have_http_status(200)
		end

	end
end
