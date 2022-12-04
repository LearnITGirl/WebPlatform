# ##################################################
# Edition with 5 Weeks
# ##################################################

current_phase = "application_registration_phase"

case current_phase
when "application_registration_phase"
    #Date.now < current_edition_reg_end_date
    current_edition_reg_start_date = DateTime.now
    current_edition_reg_end_date = 1.months.from_now
    current_edition_start_date = 2.months.from_now
    current_edition_end_date = (current_edition_start_date  + 100.days)
when "application_evaluation_phase"
    current_edition_reg_start_date = DateTime.now
    current_edition_reg_end_date = 1.months.from_now
    current_edition_start_date = 2.months.from_now
    current_edition_end_date = (current_edition_start_date  + 100.days)
when "project_ongoing_phase"
    #Phase definition
    ## if DateTime.current >= current_edition.start_date.beginning_of_day then  'ongoing_projects'
    current_edition_reg_start_date = 3.months.ago
    current_edition_reg_end_date = 2.months.ago
    current_edition_start_date = 1.months.ago
    current_edition_end_date = (1.months.ago + 100.days)
when "project_evaluation_phase"
    current_edition_reg_start_date = 3.months.ago
    current_edition_reg_end_date = 2.months.ago
    current_edition_start_date = 1.months.ago
    current_edition_end_date = (1.months.ago + 100.days)
when "final_project_evaluation_phase"
    #Phase definition
    #if (Date.today > current_edition.end_date) then  'final_project_evaluation'
    current_edition_reg_start_date = 4.months.ago
    current_edition_reg_end_date = 3.months.ago
    current_edition_start_date = 2.months.ago
    current_edition_end_date = 1.months.ago
end

edition = Edition.find_or_create_by(name: "test",
	start_date: current_edition_start_date,
	end_date: current_edition_end_date,
	registration_started_at: current_edition_reg_start_date,
	registration_closed_at: current_edition_reg_end_date)

Week.create(number: 1, start: current_edition_start_date,
	end: (current_edition_start_date + 7.days), edition_id: edition.id)

Week.create(number: 2, start: (current_edition_start_date + 8.days),
	end: (current_edition_start_date + 15.days), edition_id: edition.id)

Week.create(number: 3, start: (current_edition_start_date + 16.days),
	end: (current_edition_start_date + 23.days), edition_id: edition.id)

Week.create(number: 4, start: (current_edition_start_date + 24.days),
	end: (current_edition_start_date + 31.days), edition_id: edition.id)

Week.create(number: 5, start: (current_edition_start_date + 32.days),
	end: (current_edition_start_date + 39.days), edition_id: edition.id)