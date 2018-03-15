FactoryBot.define do
  factory :project do
    title "Project test rspec"
    language "ruby"
    description "Test a rails project using Rspec"
    github_link "https://github.com/usertest/railsRspecTest"
    mentor_id nil
    mentee_id nil
    edition_id 1
    mentor_evaluation 4
    mentee_feedback nil
    mentee_project_status 4
    github_repo_status 4
    midterm_evaluation_status 0
    last_commit nil
    programming_language_id 9
  end
end