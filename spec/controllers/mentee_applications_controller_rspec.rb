require 'rails_helper'

RSpec.describe MenteeApplicationsController, type: :controller do
	describe 'Mentee Application Controller' do

		it 'should go to new Mentee Application form' do
			edition = create(:edition)
			get :new
			expect(response).to have_http_status(200)
		end

	end
end
