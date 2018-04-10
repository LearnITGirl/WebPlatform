class FinalResultsExporter
  attr_accessor :mentors, :mentees

  def initialize
    @mentors = Project.with_passing_mentors.map{|p| p.mentor}
    @mentees = Project.with_passing_mentees.map{|p| p.mentee}
  end


  def to_csv
    attributes = %w(full_name email user_id evaluation_url github_link language)

    CSV.generate(headers: true) do |csv|
      csv << attributes

      csv << ["Mentors"]
      mentors.each do |mentor|
        url = Rails.application.routes.url_helpers.midterm_evaluation_url(mentor.project)
        csv << [
          mentor.full_name, mentor.email, mentor.id, url, mentor.project.github_link,
          mentor.project.programming_language&.name
        ]
      end

      csv << ["Mentees"]
      mentees.each do |mentee|
        url = Rails.application.routes.url_helpers.midterm_evaluation_url(mentee.project)
        csv << [
          mentee.full_name, mentee.email, mentee.id, url, mentee.project.github_link,
          mentee.project.programming_language&.name
        ]
      end
    end
  end
end
