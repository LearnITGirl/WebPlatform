class MentorApplicationValidation
  attr_reader :params, :step
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def initialize(params, step:)
    @params = params
    @step = step
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

  def validate
    case step
    when 1
      dry_validation_step_1.(params)
    when 2
      dry_validation_step_2.(params)
    when 3
      dry_validation_step_3.(params)
    when 4
      dry_validation_step_4.(params)
    when 5
      dry_validation_step_5.(params)
    end
  end

  def dry_validation_step_1
    Dry::Validation.Schema do
      configure do
        config.messages_file = 'config/locales/dry.en.yml'

        def unique?(attr_name, value)
          MentorApplication.where(attr_name => value).empty?
        end
      end

      required(:first_name).filled(:str?)
      required(:last_name).filled(:str?)
      required(:email).filled(format?: EMAIL_REGEX, unique?: :email)
      required(:gender) { filled? & (eql?('male') | eql?('female') | eql?('other'))}
      required(:country).filled(:str?)
      required(:program_country).filled(:str?)
      required(:time_zone).filled(:str?)
      required(:communicating_in_english).filled
    end
  end

  def dry_validation_step_2
    Dry::Validation.Schema do
      required(:motivation).filled(:str?)
      required(:background).filled(:str?)
    end
  end

  def dry_validation_step_3
    Dry::Validation.Schema do
      required(:git).filled
      required(:operating_system).filled(:str?)
      required(:programming_languages) { filled? & each { str? } }
    end
  end

  def dry_validation_step_4
    Dry::Validation.Schema do
      required(:application_idea).filled(:str?)
      required(:concept_explanation).filled(:str?)
    end
  end

  def dry_validation_step_5
    Dry::Validation.Schema do
      required(:time_availability).filled
      optional(:engagements).each(:filled?)
    end
  end

end
