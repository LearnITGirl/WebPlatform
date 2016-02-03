class EmailTemplateMailer < ApplicationMailer
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::TextHelper

  def custom(template, user)
    mail(to: user.email, subject: template.subject) do |format|
      format.html { render html: simple_format(parse_content template, user) }
    end
  end

  private

  def allowed_fields(user)
    if user.instance_of? User
      User.column_names - %w(crypted_password salt organiser_token)
    elsif user.instance_of? MentorApplication
      MentorApplication.column_names - %w(rejection_reason evaluator_id state)
    end
  end

  def parse_attribute user, attribute
    case value = user.send(attribute)
    when String
      value
    when Date, Time, ActiveSupport::TimeWithZone
      I18n.l(value, format: :long)
    when AvatarUploader
      image_tag(value.url)
    else
      value.to_s
    end
  end

  def parse_content(template, user)
    template.body.tap do |body|
      allowed_fields(user).each do |column|
        body.gsub!("%{#{column}}", parse_attribute(user, column))
      end
    end
  end
end
