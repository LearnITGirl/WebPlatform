class MenteeFinalSurveyForm
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus.model
  extend CarrierWave::Mount

  attribute :mentee_idea_pitch, String
  attribute :mentee_demo_url, String
  attribute :mentee_demo_file, String
  attribute :mentee_demo_file_cache, String
  attribute :mentee_recap_and_future, String
  attribute :mentee_feedback, String

  mount_uploader :mentee_demo_file, ProjectDemoUploader
  validates_with CarrierWave::Validations::ActiveModel::IntegrityValidator,
    attributes: %i(mentee_demo_file)

  validates :mentee_idea_pitch, presence: true
  validates :mentee_demo_url, presence: { message: "or demo file must be set" },
    unless: Proc.new { |f| f.mentee_demo_file.present? }
  validates :mentee_demo_file, presence: { message: "or demo url must be set" },
    unless: Proc.new { |f| f.mentee_demo_url.present? }
  validates :mentee_demo_file, file_size: { less_than: 25.megabytes }
  validates :mentee_recap_and_future, presence: true

  def initialize(attrs, user)
    super attrs
    @user = user
  end

  def save
    survey = FinalSurvey.find_or_initialize_by(project_id: @user.project.id)
    survey.update(attributes.merge({mentee_id: @user.id, edition_id: @user.id}))
    @user.badges << Badge.final_survey
  end
end

