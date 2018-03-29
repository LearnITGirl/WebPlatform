require 'rails_helper'

RSpec.describe ProjectSetup, type: :model do
  describe 'model tests' do
    let!(:edition) { create(:edition) }
    let(:programmingLanguage) { 
      ProgrammingLanguage.create(name: "Ruby", slug: "ruby") }

    let(:mentee_application) { create(:mentee_application, 
      programming_language_id: programmingLanguage.id) }

    let(:mentor_application) { create(:mentor_application) }

    it 'should create new project setup' do
      projects = 0
      ProjectSetup.new(mentor_application: mentor_application,
      mentee_application: mentee_application).create
      expect(projects+1).to be(Project.count)
    end
  end
end
