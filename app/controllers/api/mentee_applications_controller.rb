class Api::MenteeApplicationsController < ApiController
  def create
    binding.pry
    MenteeApplicationValidation.new(mentee_application_params)
  end

  private

  def mentee_application_params
    params.require(:application)
          .permit(:first_name, :last_name, :email, :gender, :country, :program_country,
                  :time_zone, :motivation, :english_level, :experience, :programming_level,
                  :background, :known_programming_languages, :programming_language,
                  :project_proposal, :programming_experience, :roadmap, :time_availability,
                  :engagements, :sources, :other_programming_language,
                  :other_known_programming_language).symbolize_keys
  end
end
