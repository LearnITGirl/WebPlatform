class  UserCreator
  def initialize(edition: Edition.last)
    @edition = edition
  end

  def add_mentor(application:)
    if user_uniq(application.email)
      User.new(user_params(application, role: 'mentor'))
    else
      User.find_by(email: application.email)
    end
  end

  def add_mentee(application:)
    if user_uniq(application.email)
      User.new(user_params(application, role: 'mentee'))
    else
      User.find_by(email: application.email)
    end
  end

  private

  def user_params(application, role:)
    {
      email: application.email,
      first_name: application.first_name,
      last_name: application.last_name,
      country: application.country,
      program_country: application.program_country,
      timezone: application.time_zone,
      edition: @edition,
      role: role
    }
  end

  def user_uniq(email)
    User.find_by(email: email).nil?
  end
end
