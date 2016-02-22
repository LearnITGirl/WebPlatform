class EmailTemplate < ActiveRecord::Base
  enum recipients: {
    accepted_mentees: 0,
    rejected_mentees: 1,
    accepted_mentors: 2,
    mentees_running_late: 3,
    mentors_missing: 4,
    mentees_not_registered: 5,
    mentors_not_registered: 6,
    mentees_abandoned: 7,
    passed_mentees: 8,
    failed_mentees: 9,
    mentors_on_waiting_list: 10,
    rejected_mentors: 11,
    mentees_on_waiting_list: 12,
    unregistered_mentees: 13,
    unregistered_mentors: 14,
    missing_project_setup_mentees: 15,
    missing_project_setup_mentors: 16
  }

  validates :subject, :body, :recipients, presence: true
  validates :recipients, inclusion: { in: EmailTemplate.recipients.keys }

  def self.search params
    where("subject ILIKE ?", "%#{params[:subject]}%")
  end

  def users
    projects, mentors_for_warning_emails, mentees_for_warning_emails = Project.all, [], []
    projects.each do |project|
      next if project.has_mentee_missing? || project.has_mentor_missing?
      if project.is_not_final?
        mentees_for_warning_emails << project.mentee
        mentors_for_warning_emails << project.mentor
      end
    end
    case recipients.to_sym
    when :accepted_mentees
      User.mentee.where(results_send_at: nil)
    when :accepted_mentors
      User.mentor.where(results_send_at: nil)
    when :mentors_on_waiting_list
      MentorApplication.waiting_list.where(results_send_at: nil)
    when :rejected_mentors
      MentorApplication.all_rejected_candidates
    when :rejected_mentees
      MenteeApplication.all_rejected_candidates
    when :mentees_on_waiting_list
      MenteeApplication.waiting_list.where(results_send_at: nil)
    when :unregistered_mentees
      User.mentee.where.not(registration_token: nil)
    when :unregistered_mentors
      User.mentor.where.not(registration_token: nil)
    when :missing_project_setup_mentees
      mentees_for_warning_emails
    when :missing_project_setup_mentors
      mentors_for_warning_emails
    else
      User.none
    end
  end
end
