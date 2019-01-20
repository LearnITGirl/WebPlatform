class Api::MentorApplicationsController < ApiController
  def create
    sanitize_params

    mentor_application_validation = MentorApplicationValidation.new(validation_params, step: params[:step])

    if mentor_application_validation.valid?
      status = :ok
    else
      errors = {keys:[], messages:[]}
      mentor_application_validation.errors.map{|k,v| errors[:keys] << k; errors[:messages] << v[0].humanize}
      status = :unprocessable_entity
    end

    if mentor_application_validation.valid? && params[:step] == params[:steps]
      mentor_application = MentorApplication.create(mentor_application_params)
      add_programming_languages(mentor_application)
      send_confirmation_email(mentor_application)
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
                  :time_availability, :gdpr_consent,
                  programming_languages_info: programming_languages_info_keys,
                  engagements: []).symbolize_keys
  end

  def validation_params
    mentor_application_params.merge params.require(:application).permit(programming_languages: []).symbolize_keys
  end

  def programming_languages_info_keys
    params[:application][:programming_languages_info].try(:keys)
  end

  def add_programming_languages(mentor_application)
    return unless validation_params[:programming_languages]

    validation_params[:programming_languages].each do |pl|
      pl = ProgrammingLanguage.where(slug: pl).first
      mentor_application.programming_languages << pl unless pl.nil?
      mentor_application.save
    end
  end

  def send_confirmation_email(mentor_application)
    return unless Rails.env.production?
    if MentorApplicationMailer.confirm_application(mentor_application).deliver_now
      mentor_application.update_attributes(confirmation_email_sent_at: Time.now)
    end
  end
end
