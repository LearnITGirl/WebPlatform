require 'rails_helper'

RSpec.describe ProjectSetup, type: :model do
	describe 'model tests' do
		before(:each) do
			@edition = create(:edition)
			@programmingLanguage = ProgrammingLanguage.create(
				name: "Ruby", slug: "ruby")
			@mentee_application = create(:mentee_application, 
				programming_language_id: @programmingLanguage.id)
			@mentor_application = create(:mentor_application)
		end

		it 'should create new project setup' do
			projects = 0
			ProjectSetup.new(mentor_application: @mentor_application,
			mentee_application: @mentee_application).create
			expect(projects+1).to be(Project.count)
		end
	end
end
