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
    validate.errors(full: true).to_h
  end

  def attrs
    validate.output
  end

  private

  def validate
    case step
    when 1
      MenteeStep1Contract.new.call(params)
    when 2
      MenteeStep2Contract.new.call(params)
    when 3
      MenteeStep3Contract.new.call(params)
    end
  end

  class MenteeStep1Contract < Dry::Validation::Contract
    config.messages.load_paths << 'config/locales/dry.en.yml'

    def unique?(attr_name, value)
      edition = Edition.where(name: ENV['ACTUAL_EDITION']).last
      MenteeApplication.where(attr_name => value)
                       .where(edition_id: edition.id).empty?
    end

    def checked?(attr_name, value)
      value
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
      required(:send_to_mentor_confirmed).filled
    end

    rule(:email) do
      key.failure(:invalid) unless unique?('email', value)
    end

    rule(:send_to_mentor_confirmed) do
      key.failure(:unchecked) unless checked?('send_to_mentor_confirmed', value)
    end
  end

  class MenteeStep2Contract < Dry::Validation::Contract
    params do
      required(:motivation).filled(:str?)
      required(:background).filled(:str?)
      required(:team_work_experience).filled(:str?)
      required(:new_learnings).filled(:str?)
    end
  end

  class MenteeStep3Contract < Dry::Validation::Contract
    config.messages.load_paths << 'config/locales/dry.en.yml'

    def checked?(value)
      value
    end

    params do
      required(:programming_language).filled(:str?)
      required(:previous_programming_experience).filled(:bool?)
      required(:project_proposal).filled(:str?)
      required(:time_availability).filled
      required(:roadmap).filled
      required(:gdpr_consent).filled
      optional(:engagements).each(:filled?)
      optional(:other_programming_languages).value(:array, size?: 1..4).each(:filled?)
      required(:previous_participation).filled(:bool?)
      optional(:perceived_methods).each(:filled?)
      optional(:programming_experience) { array? }
      optional(:programming_experience_level)
    end

    rule(:gdpr_consent) do
      key.failure(:unchecked) unless checked?(value)
    end

    rule(:programming_experience) do
      values.data[:programming_experience].each do |language_code|
        if values.data[:previous_programming_experience] && (values.data[:programming_experience_level].nil? || values.data[:programming_experience_level][language_code].nil?)
          key.failure('level of expertise must have a value')
          break
        end
      end
    end
  end
end