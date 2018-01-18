require 'rails_helper'

RSpec.describe UserRegistrationsController, type: :controller do
	describe 'User Registrations tests' do
		before(:each) do
			@organiser = create(:user)
		end

		it 'should not get edit page for user account' do
			get :edit, id: @organiser.id
			expect(response).to have_http_status(302)
		end

	end
end