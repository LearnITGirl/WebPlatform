class MailerParser::Mentor
  include Rails.application.routes.url_helpers

  attr_reader :template, :application, :allowed_attributes

  def initialize(template, application)
    @application = application
    @template = template
    @allowed_attributes = choose_attributes
  end

  def parse_attribute record, attribute
    case attribute
    when "mentee_full_name"
      application.partner.full_name
    when "mentee_country"
      Carmen::Country.coded(application.partner.country).to_s
    when "mentee_email"
      application.partner.email
    when "project_description"
      ::MenteeApplication.find_by(email: application.partner.email).try(:project_proposal).presence || "mentor should help mentee come up with a proposal"
    when "registration_link"
      edit_user_registration_url(id: application.registration_token)
    when "midterm_evaluation_url"
      new_mentor_midterm_evaluations_url
    when "final_survey_url"
      new_final_survey_url
    else
      application.send(attribute)
    end
  end

  private

  def choose_attributes
    ["accepted_mentors", "mentors_not_registered", "unregistered_mentors"].include?(@template.recipients) ?
      allowed_fields_with_link : allowed_fields
  end

  def allowed_fields
    %w(first_name last_name mentee_full_name mentee_email mentee_country project_description midterm_evaluation_url final_survey_url)
  end

  def allowed_fields_with_link
    allowed_fields << "registration_link"
  end
end
