class MenteeApplicationValidation
  EMAIL_REGEX = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  def initialize(params)
    @params = params
  end

  def valid?
    validate.success?
  end

  def errors
    validate.messages(full: true)
  end

  def attrs
    validate.output
  end

  private

  def params
    @params
  end

  def validate
    @validate ||= dry_validation_schema.(params)
  end

  def dry_validation_schema
    Dry::Validation.Schema do
      required(:first_name).filled
      required(:last_name).filled
      required(:email).filled(format?: EMAIL_REGEX)
      required(:gender) { filled? & (eql?('male') | eql?('female') | eql?('other'))}
      required(:country).filled
      required(:program_country).filled
      required(:time_zone).filled

      required(:motivation).filled
      required(:english_level) { filled? & (eql?('very well') | eql?('not so well') | eql?('good enough') | eql?('no')) }
      required(:experience).filled

      required(:programming_level) { filled? & (eql?('begginer') | eql?('medium') | eql?('advanced'))}
      required(:background).filled
      required(:programming_language).filled
      required(:project_proposal).filled
      required(:roadmap).filled

      required(:time_availability).filled
      required(:engagements).filled
      required(:sources).filled

      required(:known_programming_languages).filled
      required(:programming_experience).filled
      required(:other_programming_language).filled
      required(:other_known_programming_language).filled
    end
  end

end
