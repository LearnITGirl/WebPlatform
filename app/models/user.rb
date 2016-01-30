class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_one :mentor_project, foreign_key: "mentor_id", class_name: "Project"
  has_one :mentee_project, foreign_key: "mentee_id", class_name: "Project"

  belongs_to :edition

  accepts_nested_attributes_for :mentee_project
  accepts_nested_attributes_for :mentor_project

  has_many :mentee_applications, foreign_key: "evaluator_id"
  has_many :mentor_applications, foreign_key: "evaluator_id"
  has_many :tasks, foreign_key: "creator_id"

  mount_uploader :avatar, AvatarUploader

  enum role: {organizer: 1, mentee: 2, mentor: 3}

  validates :password, length: { minimum: 6 }, if: -> { password || password_confirmation }
  validates :password, confirmation: true, if: -> { password || password_confirmation }
  validates :password_confirmation, presence: true, if: -> { password || password_confirmation }
  validates :email,  uniqueness: { case_sensitive: false } , presence: true,  format: { with: REGEXP_EMAIL }
  validates :first_name, :last_name, :country, presence: true, on: :update

  before_create :create_organiser_token

  def full_name
    "#{first_name} #{last_name}"
  end

  def project
    role == "mentee" ? mentee_project : mentor_project
  end

  private

  def create_organiser_token
    self.organiser_token = SecureRandom.hex(8) if role == 'organizer'
  end
end
