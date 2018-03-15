require 'rails_helper'

RSpec.describe Project, type: :model do
	describe 'model tests' do
		let!(:user) { create(:user, is_missing: true) }
		let!(:edition) { create(:edition) }
		let!(:mentee) { create(:mentee) }
		let!(:mentor) { create(:mentor) }
		let!(:project) { create(:project, language: "", mentor_id: mentor.id, 
			mentee_id: mentee.id, edition_id: edition.id) }
		let!(:mentee_application) { create(:mentee_application) }
		let!(:application_match) { create(:application_match, 
			mentee_application_id: mentee_application.id) }

		it 'should check if the mentee is missing' do
			expect(project.has_mentee_missing?).to be(false)
		end

		it 'should check if the mentor is missing' do
			expect(project.has_mentor_missing?).to be(false)
		end

		it 'should check if is not final' do
			expect(project.is_not_final?).to be(true)
		end

		it 'should check if github link is valid' do
			expect(project.validate_github?).to be(true)
		end

		it 'project edition should be the last edition' do
			expect(Project.current_edition[0]).to eq(project)
		end

		it 'should get projects with failed mentors' do
			expect(Project.with_failed_mentors[0]).to eq(project)
		end

		it 'should get Projects with failed mentees' do
			expect(Project.with_failed_mentees[0]).to eq(project)
		end

		it 'should get projects with good mentors' do
			expect(Project.with_passing_mentors).to eq([])
		end

		it 'should get users with no mentor or mentee' do
			expect(Project.get_users_missing_project_setup).to eq([mentee, mentor])
		end

		it 'should get the Application Match of mentee_application' do
			applicationMatch = project.pair_matched_at().strftime("%D %r")
			# Method pair_matched_at() return the create_at with all milliseconds
			# strftime helps you to get only Date and Time with hour, minute and seconds
			expect(applicationMatch).to eq(application_match.created_at.strftime("%D %r"))
		end

		it 'should check if this week has tasks to do' do
			Week.create(number: 1, start: 14.months.from_now, 
				end: (14.months.from_now + 7.days), edition_id: edition.id)
			task = create(:task, creator_id: mentor.id, created_at: Date.today,
				project_id: project.id, week: 1, status: 1)
			
			expect(project.tasks_completed_for_week?(1)).to be(true)			
		end

		it 'should get week tests' do
			Week.create(number: 1, start: 14.months.from_now, 
				end: (14.months.from_now + 7.days), edition_id: edition.id)
			task = create(:task, creator_id: mentor.id, created_at: Date.today,
				project_id: project.id, week: 1, status: 1)
			expect(project.week_tasks(1)).to eq([task])
		end

	end
end
