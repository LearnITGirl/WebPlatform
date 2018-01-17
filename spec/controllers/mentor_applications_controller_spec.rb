require 'rails_helper'

RSpec.describe MentorApplicationsController, type: :controller do
	describe 'Mentor Application Controller' do

		it 'should get to new Mentor Application form' do
			edition = create(:edition)
			get :new
			expect(response).to have_http_status(200)
		end
		
	end
end
