require 'rails_helper'

RSpec.describe Project, type: :model do
	describe 'model tests' do
		before(:each) do
			@user = create(:user, is_missing: true)
			@edition = create(:edition)
			@mentee = create(:mentee)
			@mentor = create(:mentor)
			@project = create(:project, language: "", mentor_id: @mentor.id, mentee_id: @mentee.id, edition_id: @edition.id)
			@mentee_application = create(:mentee_application)
			@application_match = create(:application_match, mentee_application_id: @mentee_application.id)
		end

		it 'should check if the mentee is missing' do
			expect(@project.has_mentee_missing?).to be(false)
		end

		it 'should check if the mentor is missing' do
			expect(@project.has_mentor_missing?).to be(false)
		end

		it 'should check if is not final' do
			expect(@project.is_not_final?).to be(true)
		end

		it 'should check if github link is valid' do
			expect(@project.validate_github?).to be(true)
		end

		it 'project edition should be the last edition' do
			expect(Project.current_edition[0]).to eq(@project)
		end

		it 'should get projects with failed mentors' do
			expect(Project.with_failed_mentors[0]).to eq(@project)
		end

		it 'should get Projects with failed mentees' do
			expect(Project.with_failed_mentees[0]).to eq(@project)
		end

		it 'should get projects with good mentors' do
			expect(Project.with_passing_mentors).to eq([])
		end

		it 'should get users with no mentor or mentee' do
			expect(Project.get_users_missing_project_setup).to eq([@mentee, @mentor])
		end

		it 'should get the Application Match of @mentee_application' do
			applicationMatch = @project.pair_matched_at().strftime("%D %r")
			# Method pair_matched_at() return the create_at with all milliseconds
			# strftime helps you to get only Date and Time with hour, minute and seconds
			expect(applicationMatch).to eq(@application_match.created_at.strftime("%D %r"))
		end

	end
end
