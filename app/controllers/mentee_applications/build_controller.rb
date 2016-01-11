class MenteeApplications::BuildController < ApplicationController
  include Wicked::Wizard

  steps :personal_information, :experience, :programming_experience, :details, :done

  def show
    @mentee = MenteeApplication.find_by(id: params[:mentee_application_id])
    return (redirect_to root_path, notice:  "Incompleted application are deleted after 24 hours - please apply again") unless @mentee

    case step
    when :done
      return redirect_to root_path, notice: "Thank you for your application!"
    else
      return redirect_to root_path if @mentee.build_step.to_s == "done"
    end

    render_wizard
  end

  def update
    @mentee = MenteeApplication.find_by(id: params[:mentee_application_id])
    return (redirect_to root_path, notice:  "Incompleted application are deleted after 24 hours - please apply again") unless @mentee

    case step
    when :programming_experience
      @mentee.update_attributes(mentee_params.merge({known_programming_languages: (params[:known_programming_languages] || nil)}))
    when :details
      if @mentee.update_attributes(mentee_params.merge({engagements: params[:engagements], sources: params[:sources]}))
        update_programming_languages
        @mentee.update_column :build_step, :done
        MenteeApplicationMailer.confirm_application(@mentee).deliver_now
      end
    else
      @mentee.update_attributes(mentee_params)
    end

    render_wizard @mentee
  end

  def mentee_params
    return {} if params[:mentee_application].blank? && step.to_s == "details"
    param = params.require(:mentee_application).permit(
      :first_name, :last_name, :country, :email, :gender, :time_zone, :motivation,
      :english_level, :experience, :background, :programming_experience, :programming_level,
      :sources, :roadmap, :project_proposal, :engagements, :program_country, :programming_language,
      :other_known_programming_language, :other_programming_language
    ).merge({build_step: step})
    param[:time_availability] = params[:mentee_application][:time_availability].to_i if params[:mentee_application][:time_availability].present?
    param
  end

  def update_programming_languages
    index = @mentee.known_programming_languages.index("other")
    if index
      @mentee.known_programming_languages[index] = @mentee.other_known_programming_language
    end
    @mentee.programming_language = @mentee.other_programming_language if @mentee.programming_language == "other"
    @mentee.save
  end
end
