class EmailTemplateMailer < ApplicationMailer
  include ActionView::Helpers::TextHelper

  def custom(template, user)
    mail(to: user.email, subject: template.subject) do |format|
      format.html { render html: simple_format(parse_content(template, user)) }
    end
  end

  private

  def parse_content template, record
    parser = choose_parser(template, record)
    template.body.tap do |body|
      parser.allowed_attributes.each do |column|
        body.gsub!("%{#{column}}", parser.parse_attribute(record, column))
      end
    end
  end

  def choose_parser(template, user)
    if user.instance_of?(User) && user.mentor?
      MailerParser::Mentor.new(template, user)
    elsif user.instance_of?(User) && user.mentee?
      MailerParser::Mentee.new(template, user)
    elsif user.instance_of? MentorApplication
      MailerParser::MentorApplication.new(template, user)
    elsif user.instance_of? MenteeApplication
      MailerParser::MenteeApplication.new(template, user)
    end
  end
end
