class MenteeFinalSurveyForm
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model

  attribute :mentee_impression, String
  attribute :mentee_expectations, String
  attribute :mentee_project_summary, String
  attribute :mentee_future_plans, String
  attribute :mentee_feedback, String
  attribute :mentee_program_duration, String

  validates :mentee_impression, presence: true
  validates :mentee_expectations, presence: true
  validates :mentee_project_summary, presence: true
  validates :mentee_future_plans, presence: true
  validates :mentee_program_duration, presence: true

  def initialize(attrs, user)
    super attrs
    @user = user
  end

  def save
    survey = FinalSurvey.find_or_initialize_by(project_id: @user.project.id)
    survey.update_attributes(attributes.merge({mentee_id: @user.id, edition_id: @user.id}))
    @user.badges << Badge.final_survey
  end
end

