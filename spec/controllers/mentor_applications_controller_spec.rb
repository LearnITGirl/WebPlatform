require 'rails_helper'

RSpec.describe MentorApplicationsController, type: :controller do
	describe 'Mentor Application Controller' do
		let!(:edition) { create(:edition) }

		it 'should get to new Mentor Application form' do
			get :new
			expect(response).to have_http_status(200)
		end

	end
end
