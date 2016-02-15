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
  validates :avatar, file_size: { less_than_or_equal_to: 2.megabytes }

  before_create :create_token

  def full_name
    "#{first_name} #{last_name}"
  end

  def project
    role == "mentee" ? mentee_project : mentor_project
  end

  def matched_id
    role == "mentee" ? project.mentee.id : project.mentor.id
  end

  def partner
    role == "mentee" ? project.mentor : project.mentee
  end

  def new_tasks
   project.tasks.where(status: 1, created_at: ((DateTime.now - 24.hours)..DateTime.now))
  end

  def deleted_tasks
    project.tasks.where(status: 5, deleted_at: ((DateTime.now - 24.hours)..DateTime.now))
  end

  def completed_tasks
    project.tasks.where(updated_at: ((DateTime.now - 24.hours)..DateTime.now)).
      where("(status = 3) or (creator_id = :user_id and finished_by = :user_id and status = 2) or (creator_id != :user_id and finished_by != :user_id and status = 2)", {user_id: id})
  end

  def unconfirmed_completed_tasks
    project.tasks.where("(status = 2 and creator_id=(?) and creator_id != finished_by and updated_at BETWEEN (?) AND (?))", id, (DateTime.now - 24.hours), DateTime.now)
  end

  def unconfirmed_deleted_tasks
    project.tasks.where("(status = 4 and creator_id=(?) and creator_id != finished_by and updated_at BETWEEN (?) AND (?))", id, (DateTime.now - 24.hours), DateTime.now)
  end

  private

  def create_token
    if role == 'organizer'
      begin
        self.organiser_token = SecureRandom.hex(10)
      end while self.class.exists?(organiser_token: organiser_token)
    else
      begin
        self.registration_token = SecureRandom.hex(10)
      end while self.class.exists?(registration_token: registration_token)
    end
  end

end
