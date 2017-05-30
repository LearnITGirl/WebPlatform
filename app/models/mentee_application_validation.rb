class MenteeApplicationValidation
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
    end
  end

  def dry_validation_step_1
    Dry::Validation.Schema do
      configure do
        config.messages_file = 'config/locales/dry.en.yml'

        def unique?(attr_name, value)
          edition = Edition.where(name: ENV['ACTUAL_EDITION']).last
          MenteeApplication.where(attr_name => value)
            .where(edition_id: edition.id).empty?
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
      required(:team_work_experience).filled(:str?)
    end
  end

  def dry_validation_step_3
    Dry::Validation.Schema do
      required(:programming_language).filled(:str?)
      required(:previous_programming_experience).filled(:bool?)
      required(:operating_system).filled(:str?)
      required(:project_proposal).filled(:str?)
      required(:time_availability).filled
      required(:roadmap).filled
      optional(:engagements).each(:filled?)
    end
  end
end
