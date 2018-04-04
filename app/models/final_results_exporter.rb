class FinalResultsExporter
  attr_accessor :mentors, :mentees

  def initialize
    @mentors = Project.with_passing_mentors.map{|p| p.mentor}
    @mentees = Project.with_passing_mentees.map{|p| p.mentee}
  end


  def to_csv
    attributes = %w(full_name email evaluation_url)

    CSV.generate(headers: true) do |csv|
      csv << attributes

      mentors.each do |mentor|
        url = Rails.application.routes.url_helpers.midterm_evaluation_url(mentor.project)
        csv << [mentor.full_name, mentor.email, url]
      end

      mentees.each do |mentee|
        url = Rails.application.routes.url_helpers.midterm_evaluation_url(mentee.project)
        csv << [mentee.full_name, mentee.email, url]
      end
    end
  end
end
