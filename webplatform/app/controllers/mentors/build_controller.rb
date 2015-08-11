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
    @mentor.update_attributes(mentor_params)
    render_wizard @mentor
  end

  def mentor_params
    params.require(:mentor).permit(
      :first_name, :last_name, :country, :email, :gender, :time_zone, :motivation,
      :english_level, :experienced, :mentor_experience, :background, :git,
      :programming_languages, :programming_experience, :sources, :application_idea,
      :concept_explanation, :time_availability, :engagements, :program_country
    )
  end
end
