class  UserCreator
  def initialize(edition: Edition.last)
    @edition = edition
  end

  def add_mentor(application:)
    if user_uniq(application.email)
      User.new(user_params(application, role: 'mentor'))
    else
      user = User.find_by(email: application.email)
      user.update_attributes(user_params(application, role: 'mentor', user: user))
      user
    end
  end

  def add_mentee(application:)
    if user_uniq(application.email)
      User.new(user_params(application, role: 'mentee'))
    else
      user = User.find_by(email: application.email)
      user.update_attributes(user_params(application, role: 'mentee', user: user))
      user
    end
  end

  private

  def user_params(application, role:, user: nil)
    {
      email: application.email,
      first_name: application.first_name,
      last_name: application.last_name,
      country: application.country,
      program_country: application.program_country,
      timezone: application.time_zone,
      edition: @edition,
      role: role,
      mentee_application_id: mentee_application_id(application, role, user: user),
      mentor_application_id: mentor_application_id(application, role, user: user)
    }
  end

  def mentee_application_id(application, role, user: nil)
    if role == "mentee"
      application.id
    elsif user
      user.mentee_application_id
    end
  end

  def mentor_application_id(application, role, user: nil)
    if role == "mentor"
      application.id
    elsif user
      user.mentor_application_id
    end
  end

  def user_uniq(email)
    User.find_by(email: email).nil?
  end
end
