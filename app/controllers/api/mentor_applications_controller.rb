class Api::MentorApplicationsController < ApiController
  def create
    sanitize_params

    mentor_application_validation = MentorApplicationValidation.new(mentor_application_params, step: params[:step])
    if mentor_application_validation.valid?
      status = :ok
    else
      errors = {keys:[], messages:[]}
      mentor_application_validation.errors.map{|k,v| errors[:keys] << k; errors[:messages] << v[0].humanize}
      status = :unprocessable_entity
    end

    if mentor_application_validation.valid? && params[:step] == params[:steps]
      MentorApplication.create(mentor_application_params)
      flash[:notice] = 'Thank you for your application!'
    end

    render json: {errors: (errors || nil)}, status: status
  end

  private

  def sanitize_params
    params[:application][:time_availability] = eval params[:application][:time_availability]
    params[:application][:communicating_in_english] = eval params[:application][:communicating_in_english]
    params[:step] = params[:step].to_i
    params[:steps] = params[:steps].to_i
  end

  def mentor_application_params
    params.require(:application)
          .permit(:first_name, :last_name, :email, :gender, :country, :program_country,
                  :time_zone, :communicating_in_english,
                  :motivation, :background, :mentor_experience,
                  :git, :operating_system,
                  :application_idea, :concept_explanation,
                  :time_availability,
                  programming_languages_info: programming_languages_info_keys,
                  engagements: [], programming_languages: []).symbolize_keys
  end

  def programming_languages_info_keys
    params[:application][:programming_languages_info].try(:keys)
  end
end
