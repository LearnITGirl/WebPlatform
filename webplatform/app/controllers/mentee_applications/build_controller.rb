class MenteeApplications::BuildController < ApplicationController
  include Wicked::Wizard

  steps :personal_information, :experience, :programming_experience, :details, :done

  def show
    @mentee = MenteeApplication.find(params[:mentee_application_id])

    case step
    when :done
      return redirect_to root_path, notice: "Thank you for your application!"
    else
      return redirect_to root_path if @mentee.build_step.to_s == "done"
    end

    render_wizard
  end

  def update
    @mentee = MenteeApplication.find(params[:mentee_application_id])

    case step
    when :programming_experience
      if params[:known_programming_languages].present? && params[:known_programming_languages].include?("other")
        params[:known_programming_languages] << params[:other_language]
      elsif params[:known_programming_languages].blank?
        params[:known_programming_languages] = []
      end
      @mentee.update_attributes(mentee_params.merge({known_programming_languages: params[:known_programming_languages]}))
    when :details
      if @mentee.update_attributes(mentee_params.merge({engagements: params[:engagements], sources: params[:sources]}))
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
      :sources, :roadmap, :project_proposal, :engagements, :program_country, :programming_language
    ).merge({build_step: step})
    param[:time_availability] = params[:mentee_application][:time_availability].to_i if params[:mentee_application][:time_availability].present?
    param[:programming_language] = params[:other_lang] if param[:programming_language] == "other"
    param
  end
end
