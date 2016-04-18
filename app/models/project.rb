class Project < ActiveRecord::Base
  belongs_to :mentor, class_name: 'User', foreign_key: "mentor_id"
  belongs_to :mentee, class_name: 'User', foreign_key: "mentee_id"
  has_many :tasks, dependent: :destroy

  belongs_to :edition

  validates :mentee_id, presence: true, on: :update
  validates :title, :language, :description, :github_link, presence: true, on: :update

  validates :github_link, format: { with: GITHUB_REGEXP }, on: :update

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
        pair_matched_at = ApplicationMatch.find_by(mentee_application_id: mentee_application.id).created_at
      end
    end
    pair_matched_at
  end
end
