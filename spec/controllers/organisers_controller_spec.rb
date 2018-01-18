require 'rails_helper'

RSpec.describe OrganisersController, type: :controller do
	describe 'Organisers Controller GET Tests' do
		before(:each) do
			@organiser = create(:user)
		end

		it 'should get the organiser dashboard' do
			edition = create(:edition)
			login_user(@organiser)
			get :dashboard, user: @organiser
			expect(response).to have_http_status(200)
		end

		it 'should get organiser dashboard with "final_project_evaluation"' do
			edition = Edition.create(name: "test",
				start_date: 100.days.ago,
				end_date: (10.days.ago),
				registration_started_at: 200.days.ago,
				registration_closed_at: 185.days.ago)
			login_user(@organiser)
			get :dashboard, user: @organiser
			expect(response).to have_http_status(200)
		end

		it 'should get organiser dashboard with "ongoing_projects"' do
			edition = Edition.create(name: "test",
				start_date: 100.days.ago,
				end_date: (10.days.from_now),
				registration_started_at: 200.days.ago,
				registration_closed_at: 185.days.ago)
			login_user(@organiser)
			get :dashboard, user: @organiser
			expect(response).to have_http_status(200)
			# Something like this would be better
			# expect(response).to render_template(file: 'app/views/organisers/ongoing_projects.slim')
		end

		it 'should get index page with some organisers' do
			login_user(@organiser)
			get :index
			expect(response).to have_http_status(200)
			expect(assigns(:pending_organisers)[0]).to eq(@organiser)
		end

		it 'should not get problematic projects' do
			edition = create(:edition)
			mentor = create(:mentor, last_activity_at: 2.days.ago)
			mentee = create(:mentee, is_missing: false, last_activity_at: 2.days.ago)
			project = create(:project, language: "", mentor_id: mentor.id, mentee_id: mentee.id, edition_id: edition.id)
			login_user(@organiser)
			get :problematic_projects
			expect(assigns(:projects)[0]).to be(nil)
		end

		it 'should get problematic projects' do
			edition = create(:edition)
			mentor = create(:mentor, last_activity_at: 2.days.ago)
			mentee = create(:mentee, is_missing: true, last_activity_at: 2.days.ago)
			project = create(:project, language: "", mentor_id: mentor.id, mentee_id: mentee.id, edition_id: edition.id)
			login_user(@organiser)
			get :problematic_projects
			expect(assigns(:projects)[0]).to eq(project)
		end

		it 'should go to edit page' do
			login_user(@organiser)
			get :edit, id: @organiser.id
			expect(response).to have_http_status(200)
		end
	end

	describe 'Organisers Controller CRUD Tests' do
		before(:each) do
			@organiser = create(:user)
		end

		it 'should not create a new organizer' do
			login_user(@organiser)
			post :create
			expect(User.count).to eq(1)
		end

		it 'should create a new organizer' do
			login_user(@organiser)
			post :create, email: 'new_organiser@email.com'
			expect(User.count).to eq(2)
		end

		it 'should update Organiser first_name' do
			login_user(@organiser)
			patch :update, id: @organiser.id, user: { first_name: 'Organiser', country: "Brazil" }
			expect(@organiser.first_name).to eq('Organiser')
			expect(response).to redirect_to(organisers_path)
			expect(flash[:notice]).to eq("Details were successfully updated.")
		end

		it 'should not update Organiser' do
			login_user(@organiser)
			patch :update, id: @organiser.id, user: { first_name: '' }
			expect(response).to have_http_status(200)
		end

		it 'should delete the Organiser' do
			request.env["HTTP_REFERER"] = "http://localhost:3000"
			edition = create(:edition)
			login_user(@organiser)
			get :dashboard, user: @organiser
			delete :destroy, id: @organiser.id
			expect(flash[:notice]).to eq("Deleted successfully!")
			expect(User.count).to be(0)
		end

	end
end