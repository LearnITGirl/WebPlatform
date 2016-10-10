class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_one :mentor_project, foreign_key: "mentor_id", class_name: "Project"
  has_one :mentee_project, foreign_key: "mentee_id", class_name: "Project"

  has_one :mentor_final_survey, foreign_key: "mentor_id", class_name: "FinalSurvey"
  has_one :mentee_final_survey, foreign_key: "mentee_id", class_name: "FinalSurvey"

  has_one :mentee_midterm_evaluation, foreign_key: "mentee_id", class_name: "MenteeMidtermEvaluation"
  has_one :mentor_midterm_evaluation, foreign_key: "mentor_id", class_name: "MentorMidtermEvaluation"

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

  def last_week_tasks(date)
    project.tasks.where(updated_at: (date.beginning_of_week..date.end_of_week))
  end

  def midterm_self_evaluation
    mentee? ? mentee_midterm_evaluation : mentor_midterm_evaluation
  end

  def final_survey
    role == "mentee" ? mentee_final_survey : mentor_final_survey
  end

  def self.mentees_missing_on_website
    mentees_missing = User.mentee.where("last_activity_at is null or last_activity_at <= (?)", 15.days.ago)
    mentees_missing = mentees_missing.where.not("is_missing = (?) OR (send_warning_email_after is not null AND send_warning_email_after > (?))", true, Date.today)
    # Exclude mentees just matched or rematched
    projects = Project.where("mentee_id IN (?)", mentees_missing.pluck(:id))
    mentees_just_matched = []
    projects.each do |project|
      if project.pair_matched_at >= 10.days.ago
        mentees_just_matched << project.mentee_id
      end
    end
    mentees_missing.where.not("id IN (?)", mentees_just_matched)
  end

  def self.mentors_missing_on_website
    mentors_missing = User.mentor.where("last_activity_at is null or last_activity_at <= (?)", 15.days.ago)
    mentors_missing = mentors_missing.where.not("is_missing = (?) OR (send_warning_email_after is not null AND send_warning_email_after > (?))", true, Date.today)
    # Exclude mentors just matched or rematched
    projects = Project.where("mentor_id IN (?)", mentors_missing.pluck(:id))
    mentors_just_matched = []
    projects.each do |project|
      if project.pair_matched_at >= 10.days.ago
        mentors_just_matched << project.mentor_id
      end
    end
    mentors_missing.where.not("id IN (?)", mentors_just_matched)
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
