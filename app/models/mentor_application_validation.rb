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
    validate.errors(full: true).to_h
  end

  def attrs
    validate.output
  end

  private

  def validate
    case step
    when 1
      MentorStep1Contract.new.call(params)
    when 2
      MentorStep2Contract.new.call(params)
    when 3
      MentorStep3Contract.new.call(params)
    when 4
      MentorStep4Contract.new.call(params)
    when 5
      MentorStep5Contract.new.call(params)
    end
  end

  def dry_validation_step_5
    Dry::Validation.Schema do
      configure do
        config.messages_file = 'config/locales/dry.en.yml'

        def checked?(attr_name, value)
          value
        end
      end
      required(:time_availability).filled
      required(:gdpr_consent).filled(checked?: :gdpr_consent)
      optional(:engagements).each(:filled?)
    end
  end

  class MentorStep1Contract < Dry::Validation::Contract
    config.messages.load_paths << 'config/locales/dry.en.yml'

    def unique?(attr_name, value)
      edition = Edition.where(name: ENV['ACTUAL_EDITION']).last
      MenteeApplication.where(attr_name => value)
                       .where(edition_id: edition.id).empty?
    end

    params do
      required(:first_name).filled(:str?)
      required(:last_name).filled(:str?)
      required(:email).filled(format?: EMAIL_REGEX)
      required(:gender) { filled? & (eql?('male') | eql?('female') | eql?('other')) }
      required(:country).filled(:str?)
      required(:program_country).filled(:str?)
      required(:time_zone).filled(:str?)
      required(:communicating_in_english).filled
    end

    rule(:email) do
      key.failure(:invalid) unless unique?('email', value)
    end
  end

  class MentorStep2Contract < Dry::Validation::Contract
    params do
      required(:motivation).filled(:str?)
      required(:background).filled(:str?)
      required(:like_mentoring_beginner).filled
    end
  end

  class MentorStep3Contract < Dry::Validation::Contract
    params do
      required(:git).filled
      required(:programming_languages) { filled? & each { str? } }
    end
  end

  class MentorStep4Contract < Dry::Validation::Contract
    params do
      required(:application_idea).filled(:str?)
    end
  end

  class MentorStep5Contract < Dry::Validation::Contract
    config.messages.load_paths << 'config/locales/dry.en.yml'

    def checked?(value)
      value
    end

    params do
      required(:time_availability).filled
      required(:gdpr_consent).filled
      optional(:engagements).each(:filled?)
      optional(:perceived_methods).each(:filled?)
    end

    rule(:gdpr_consent) do
      key.failure(:unchecked) unless checked?(value)
    end
  end
end
