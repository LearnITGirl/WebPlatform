class EmailTemplate < ActiveRecord::Base
  enum recipients: {
    accepted_mentees: 0,
    not_accepted_mentees: 1,
    accepted_mentors: 2,
    mentees_running_late: 3,
    mentors_missing: 4,
    mentees_not_registered: 5,
    mentors_not_registered: 6,
    mentees_abandoned: 7,
    passed_mentees: 8,
    failed_mentees: 9,
    mentors_on_waiting_list: 10
  }

  validates :subject, :body, :recipients, presence: true
  validates :recipients, inclusion: { in: EmailTemplate.recipients.keys }

  def self.search params
    where("subject ILIKE ?", "%#{params[:subject]}%")
  end

  def users
    case recipients.to_sym
    when :accepted_mentees
      User.mentee
    when :accepted_mentors
      User.mentor
    when :mentors_on_waiting_list
      MentorApplication.waiting_list
    else
      User.none
    end
  end
end
