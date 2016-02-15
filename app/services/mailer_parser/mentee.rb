class MailerParser::Mentee
  include Rails.application.routes.url_helpers

  attr_reader :template, :mentee, :allowed_attributes

  def initialize(template, mentee)
    @mentee = mentee
    @template = template
    @allowed_attributes = allowed_fields
  end

  def parse_attribute record, attribute
    case attribute
    when "mentor_full_name"
      mentee.partner.full_name
    when "mentor_country"
      Carmen::Country.coded(mentee.partner.country).to_s
    when "mentor_email"
      mentee.partner.email
    when "registration_link"
      edit_user_registration_url(id: mentee.registration_token)
    when "roadmap_link"
      roadmap_example_url
    else
      mentee.send(attribute)
    end
  end

  private

  def allowed_fields
    %w(first_name last_name mentor_full_name mentor_email mentor_country roadmap_link)
  end
end
