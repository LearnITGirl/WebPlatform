class FinalSurveysController < ApplicationController
  before_action :require_mentee_or_mentor, :already_submitted

  def new
    @survey = form(true)
  end

  def create
    @survey = form

    if @survey.valid?
      @survey.save
      redirect_to root_path, notice: "Thank you for filling in your final evaluation"
    else
      render "new"
    end
  end

  private

  def form(is_empty=false)
    if current_user.mentee?
      attrs = is_empty ? {} : mentee_survey_param
      MenteeFinalSurveyForm.new(attrs, current_user)
    else
      attrs = is_empty ? {} : mentor_survey_param
      MentorFinalSurveyForm.new(attrs, current_user)
    end
  end

  def mentee_survey_param
    params.require(:mentee_final_survey_form).permit(
      :mentee_impression, :mentee_expectations, :mentee_project_summary, :mentee_future_plans,
      :mentee_feedback, :mentee_program_duration
    )
  end

  def mentor_survey_param
    params.require(:mentor_final_survey_form).permit(
      :mentor_impression, :mentor_expectations, :mentor_project_summary, :mentor_feedback,
      :mentor_program_duration
    )
  end

  def require_mentee_or_mentor
    if current_user.blank? || current_user.organizer?
      redirect_to root_path, notice: "You need to login as mentor or mentee"
    end
  end

  def already_submitted
    if current_user.final_survey.present?
      redirect_to root_path, notice: "You've already filled in your final self-evaluation!"
    end
  end
end
