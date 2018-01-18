require 'rails_helper'

RSpec.describe TasksController, type: :controller do
	describe 'Tasks Controller' do
		before(:each) do
			@edition = create(:edition)
			Week.create(number: 1, start: 14.months.from_now, 
				end: (14.months.from_now + 7.days), edition_id: @edition.id)
			Week.create(number: 2, start: (14.months.from_now + 8.days),
				end: (14.months.from_now + 15.days), edition_id: @edition.id)
			Week.create(number: 3, start: (14.months.from_now + 16.days),
				end: (14.months.from_now + 23.days), edition_id: @edition.id)
			Week.create(number: 4, start: (14.months.from_now + 24.days),
				end: (14.months.from_now + 31.days), edition_id: @edition.id)
			Week.create(number: 5, start: (14.months.from_now + 32.days),
				end: (14.months.from_now + 39.days), edition_id: @edition.id)
			@organiser = create(:user)
			@mentee = create(:mentee)
			@mentor = create(:mentor)
			@project = create(:project, mentor_id: @mentor.id, mentee_id: @mentee.id)
		end

		it 'should not create a new Task' do
			login_user(@mentor)
			post :create, task: {
				title: nil,
				creator_id: @mentor.id, created_at: Date.today, status: nil,
				project_id: @project.id, week: Week.first.id, finished_by: nil,
				deleted_at: nil, updated_at: nil, completed_at: nil
			}
			expect(Task.count).to eq(0)
		end

		it 'should create a new Task' do
			login_user(@mentor)
			post :create, task: {
				title: "Task 01 - Test Complete",
				creator_id: @mentor.id, created_at: Date.today, status: nil,
				project_id: @project.id, week: Week.first.id, finished_by: nil,
				deleted_at: nil, updated_at: nil, completed_at: nil
			}
			expect(Task.count).to eq(1)
		end

		describe 'GET, UPDATE and DESTROY tests' do
			before(:each) do
				login_user(@mentor)
				@task = create(:task, creator_id: @mentor.id, created_at: Date.today,
					project_id: @project.id, week: Week.first.id)
			end
			it 'should get edit page' do
				get :edit, id: @task.id
				expect(response).to have_http_status(200)
			end
	
			it 'should update Task title' do
				put :update, id: @task.id, task: { title: "Task 01 - Test Complete edited" }
				expect(Task.first.title).to eq('Task 01 - Test Complete edited')
			end

			it 'should update Task with status = 3' do
				task2 = create(:task, creator_id: @mentor.id, created_at: Date.today,
					project_id: @project.id, status: 3, week: 1, finished_by: @mentor.id)
				put :update, id: task2.id, task: { status: 3 }, week: 1
				expect(Task.first.finished_by).to eq(nil)
			end

			it 'should not update Task title' do
				put :update, id: @task.id, task: { title: "" }
				expect(response).to have_http_status(422)
			end

			it 'should destroy a Task' do
				deleteTime = DateTime.current
				request.env["HTTP_REFERER"] = "http://localhost:3000"
				delete :destroy, id: @task.id
				expect(flash[:notice]).to eq('Deleted successfully!')
				expect(Task.first.status).to eq("deleted")
				expect(Task.first.deleted_at).to be >	deleteTime
			end

			it 'should accept a Task' do
				put :accept, id: @task.id, week: 1
				expect(Task.first.status).to eq('accepted')
			end

		end

	end
end