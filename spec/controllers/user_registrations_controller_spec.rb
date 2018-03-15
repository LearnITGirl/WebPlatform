require 'rails_helper'

RSpec.describe UserRegistrationsController, type: :controller do
	describe 'User Registrations tests' do
		let(:organiser) { create(:user) }

		it 'should not get edit page for user account' do
			get :edit, id: organiser.id
			expect(response).to have_http_status(302)
		end

	end
end