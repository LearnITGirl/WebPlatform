FactoryBot.define do
  factory :simple_mentee_midterm_evaluation, class: MenteeMidtermEvaluation do
    mentee_id 1
    project_progress "Finished all tasks"
    language_progress "Good progress on ruby"
    positive_aspects "Many positive aspects"
    future_plans "Update the project"
    weekly_hours 3
    mentor_impression "A good mentor impression"
    extra_info nil
    edition_id nil
  end
end