class MentorFinalSurveyForm
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model

  attribute :mentor_impression, String
  attribute :mentor_expectations, String
  attribute :mentor_project_summary, String
  attribute :mentor_feedback, String
  attribute :mentor_program_duration, String

  validates :mentor_impression, presence: true
  validates :mentor_expectations, presence: true
  validates :mentor_project_summary, presence: true
  validates :mentor_program_duration, presence: true

  def initialize(attrs, user)
    super attrs
    @user = user
  end

  def save
    survey = FinalSurvey.find_or_initialize_by(project_id: @user.project.id)
    survey.update_attributes(attributes.merge({mentor_id: @user.id, edition_id: @user.id}))
  end
end

