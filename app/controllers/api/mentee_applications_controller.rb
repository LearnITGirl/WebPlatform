class Api::MenteeApplicationsController < ApiController
  def create
    sanitize_params

    mentee_application_validation = MenteeApplicationValidation.new(mentee_application_params, step: params[:step])
    if mentee_application_validation.valid?
      status = :ok
    else
      errors = {keys:[], messages:[]}
      mentee_application_validation.errors.map{|k,v| errors[:keys] << k; errors[:messages] << v[0].humanize}
      status = :unprocessable_entity
    end

    if mentee_application_validation.valid? && params[:step] == 3
      MenteeApplication.create(mentee_application_validation.attrs)
      flash[:notice] = 'Thank you for your application!'
    end

    render json: {errors: (errors || nil)}, status: status
  end

  private

  def sanitize_params
    params[:application][:time_availability] = eval params[:application][:time_availability]
    params[:application][:communicating_in_english] = eval params[:application][:communicating_in_english]
    params[:application][:send_to_mentor_confirmed] = eval params[:application][:send_to_mentor_confirmed]
    params[:application][:previous_programming_experience] = eval params[:application][:previous_programming_experience]
    params[:step] = params[:step].to_i
  end

  def mentee_application_params
    params.require(:application)
          .permit(:first_name, :last_name, :email, :gender, :country, :program_country,
                  :time_zone, :communicating_in_english, :send_to_mentor_confirmed,
                  :motivation, :background, :team_work_experience,
                  :programming_language, :previous_programming_experience, :experience,
                  :operating_system, :project_proposal, :roadmap, :time_availability,
                  :engagements).symbolize_keys
  end
end
