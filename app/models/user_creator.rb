class  UserCreator
  def initialize(edition: Edition.last)
    @edition = edition
  end

  def add_mentor(application:)
    User.create!(user_params(application, role: 'mentor'))
  end

  def add_mentee(application:)
    User.create!(user_params(application, role: 'mentee'))
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
end
