require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
	describe 'tests' do

		it 'should show a Project' do
			project = create(:project)
			edition = create(:edition)

			Week.create(number: 1, start: 14.months.from_now, 
			end: (14.months.from_now + 7.days), edition_id: edition.id)
			Week.create(number: 2, start: (14.months.from_now + 8.days),
			end: (14.months.from_now + 15.days), edition_id: edition.id)
			Week.create(number: 3, start: (14.months.from_now + 16.days),
			end: (14.months.from_now + 23.days), edition_id: edition.id)
			Week.create(number: 4, start: (14.months.from_now + 24.days),
			end: (14.months.from_now + 31.days), edition_id: edition.id)
			Week.create(number: 5, start: (14.months.from_now + 32.days),
			end: (14.months.from_now + 39.days), edition_id: edition.id)

			get :show, id: project.id
			expect(response).to have_http_status(200)
		end

	end
end