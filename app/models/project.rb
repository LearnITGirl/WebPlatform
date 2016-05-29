class Project < ActiveRecord::Base
  belongs_to :mentor, class_name: 'User', foreign_key: "mentor_id"
  belongs_to :mentee, class_name: 'User', foreign_key: "mentee_id"
  has_many :tasks, dependent: :destroy
  has_one :final_survey

  belongs_to :edition

  belongs_to :mentor_midterm_evaluation, class_name: 'User', foreign_key: "mentor_id"
  belongs_to :mentee_midterm_evaluation, class_name: 'User', foreign_key: "mentee_id"

  validates :mentee_id, presence: true, on: :update,
  if: -> {!mentor_evaluation || !mentee_feedback || !mentee_project_status || !github_repo_status}

  validates :title, :language, :description, :github_link, presence: true, on: :update,
  unless: "midterm_evaluation_pending?"

  validates :github_link, format: { with: GITHUB_REGEXP }, on: :update,
  unless: "midterm_evaluation_pending?"

  validates :mentor_evaluation, :mentee_feedback, :mentee_project_status, :github_repo_status, presence: true,
  if: "midterm_evaluation_pending?"

  enum mentor_evaluation: {
    "The mentor is doing an excellent work": 1,
    "The mentor is doing well": 2,
    "The mentor is working, but should improve": 3,
    "The mentor is not working": 4
  }

  enum mentee_feedback: {
    "The mentee says she has worked less than her mentor described": 1,
    "The mentee description of her work is according to what her mentor said": 2,
    "The mentee says she has worked more than her mentor described": 3,
    "Not applicable": 4
  }

  enum mentee_project_status: {
    "The mentee has done an outstanding work": 1,
    "The mentee has worked well": 2,
    "The mentee hasn't finished the project, but has progressed and worked constantly": 3,
    "The mentee has not worked or stopped working during the programme": 4
  }

  enum github_repo_status: {
    "Contains all the work described": 1,
    "Contains most of the work described": 2,
    "Contains only part of the work described here": 3,
    "Contains a different work than the one described here": 4,
    "Doesn't contain any work": 5,
    "The link is wrong": 6
  }

  enum midterm_evaluation_status: { midterm_evaluation_unstarted: 0, midterm_evaluation_pending: 1, midterm_evaluation_completed: 2 }

  def week_tasks(week)
    tasks.where("week = :week_number or (status = 1 and week < :week_number)", {week_number: week})
  end

  def has_mentee_missing?
    self.mentee.is_missing == true
  end

  def has_mentor_missing?
    self.mentor.is_missing == true
  end

  def is_not_final?
    self.title.blank? || self.language.blank? || self.description.blank? || self.github_link.blank?
  end

  def self.get_users_missing_project_setup
    projects, users_missing_project_setup = Project.all, []
    projects.each do |project|
      next if project.has_mentee_missing? || project.has_mentor_missing?
      if project.is_not_final?
        users_missing_project_setup << project.mentee << project.mentor
      end
    end
    users_missing_project_setup
  end

  def pair_matched_at
    pair_matched_at = nil
    if self.mentee.present?
      mentee_application = MenteeApplication.find_by_email(self.mentee.email)
      if mentee_application.present?
        pair_matched_at = ApplicationMatch.find_by(mentee_application_id: mentee_application.id).try(:created_at)
      end
    end
    pair_matched_at
  end
end
