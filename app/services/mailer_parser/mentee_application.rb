class MailerParser::MenteeApplication
  attr_reader :template, :record, :allowed_attributes

  def initialize(template, record)
    @template = template
    @record = record
    @allowed_attributes = allowed_fields
  end

  def parse_attribute record, attribute
    case value = record.send(attribute)
    when String
      value
    when Date, Time, ActiveSupport::TimeWithZone
      I18n.l(value, format: :long)
    else
      value.to_s
    end
  end

  private

  def allowed_fields
    %w(first_name last_name)
  end

end
