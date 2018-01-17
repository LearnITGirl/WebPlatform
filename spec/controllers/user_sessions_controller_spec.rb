require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
	describe "Users Sessions controller tests" do
		before(:each) do
			@organiser = create(:user)
		end

    it "should set a new session instance" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

		# it "should create an user session" do
		# 	get :new
		# 	post :create, session: @organiser
		# 	expect(controller.current_user.first_name).to eq('Mentor')
		# 	expect(flash[:notice]).to eq("Login Succesful!")
		# end

		it "should destroy an user session" do
			login_user(@organiser)
			get :destroy
			expect(controller.current_user).to be(nil)
			expect(flash[:notice]).to eq("Logged out!")
		end

	end
end