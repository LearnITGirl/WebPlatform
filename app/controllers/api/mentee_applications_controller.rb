class Api::MenteeApplicationsController < ApiController
  def create
    sanitize_params

    mentee_application_validation = MenteeApplicationValidation.new(validation_params, step: params[:step])
    if mentee_application_validation.valid?
      status = :ok
    else
      errors = {keys:[], messages:[]}
      mentee_application_validation.errors.map{|k,v| errors[:keys] << k; errors[:messages] << v[0].humanize}
      status = :unprocessable_entity
    end

    if mentee_application_validation.valid? && params[:step] == params[:steps]
      mentee_application = MenteeApplication.create(mentee_application_params)
      add_programming_language(mentee_application)
      send_confirmation_email(mentee_application)
      flash[:notice] = 'Thank you for your application!'
    end

    render json: {errors: (errors || nil)}, status: status
  end

  private

  def sanitize_params
    params[:application][:time_availability] = eval params[:application][:time_availability]
    params[:application][:communicating_in_english] = eval params[:application][:communicating_in_english]
    params[:application][:send_to_mentor_confirmed] = eval(params[:application][:send_to_mentor_confirmed].presence || "")
    params[:application][:previous_programming_experience] = eval params[:application][:previous_programming_experience]
    params[:application][:gdpr_consent] = eval(params[:application][:gdpr_consent].presence || "")
    params[:step] = params[:step].to_i
    params[:steps] = params[:steps].to_i
  end

  def mentee_application_params
    params.require(:application)
          .permit(:first_name, :last_name, :email, :gender, :country, :program_country,
                  :time_zone, :communicating_in_english, :send_to_mentor_confirmed,
                  :motivation, :background, :team_work_experience, :new_learnings,
                  :previous_programming_experience, :experience, :gdpr_consent,
                  :operating_system, :project_proposal, :roadmap, :time_availability,
                  engagements: []).to_h
  end

  def validation_params
    mentee_application_params.merge params.require(:application).permit(:programming_language).to_h
  end

  def add_programming_language(mentee_application)
    return unless validation_params[:programming_language]
    pl = ProgrammingLanguage.where(slug: validation_params[:programming_language]).first
    mentee_application.programming_language = pl unless pl.nil?
    mentee_application.save
  end

  def send_confirmation_email(mentee_application)
    return unless Rails.env.production?
    if MenteeApplicationMailer.confirm_application(mentee_application).deliver_now
      mentee_application.update(confirmation_email_sent_at: Time.now)
    end
  end
end
