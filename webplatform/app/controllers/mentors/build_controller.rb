class Mentors::BuildController < ApplicationController
  include Wicked::Wizard

  steps :personal_information, :experience, :programming_experience, :details, :done

  def show
    @mentor = Mentor.find(params[:mentor_id])

    #case step
    #when :personal_information
    #end
    render_wizard
  end

  def update
    @mentor = Mentor.find(params[:mentor_id])

    case step
    when :experience
      @mentor.update_attributes(mentor_params.merge({mentee_level: params[:mentee_level]}))
    when :programming_experience
      if params[:programming_languages].present? && params[:programming_languages].include?("other")
        params[:programming_languages] << params[:other_language]
      elsif params[:programming_languages].blank?
        params[:programming_languages] = []
      end
      @mentor.update_attributes(mentor_params.merge({programming_languages: params[:programming_languages]}))
    else
      @mentor.update_attributes(mentor_params)
    end

    render_wizard @mentor
  end

  def mentor_params
    params.require(:mentor).permit(
      :first_name, :last_name, :country, :email, :gender, :time_zone, :motivation,
      :english_level, :experienced, :mentor_experience, :background, :git,
      :programming_experience, :sources, :application_idea, :concept_explanation,
      :time_availability, :engagements, :program_country
    ).merge({build_step: step})
  end
end
