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
    failed_mentees: 9
  }

  validates :subject, :body, :recipients, presence: true
  validates :recipients, inclusion: { in: EmailTemplate.recipients.keys }

  def self.search params
    where("subject ILIKE ?", "%#{params[:subject]}%")
  end

  def users
    case recipients.to_sym
    when :accepted_mentees, :not_accepted_mentees, :mentees_running_late, :mentees_not_registered,
         :mentees_abandoned, :passed_mentees, :failed_mentees
      User.mentee
    when :accepted_mentors, :mentors_missing, :mentors_not_registered
      User.mentor
    else
      User.none
    end
  end
end