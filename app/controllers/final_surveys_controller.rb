class FinalSurveysController < ApplicationController
  before_action :require_mentee_or_mentor, :already_submitted

  def new
    render_form(form(true))
  end

  def create
    survey = form

    if survey.valid? && survey.save
      redirect_to root_path, notice: "Thank you for filling in your final evaluation"
    else
      render_form(clean_survey_params(survey))
    end
  end

  def show
    redirect_to action: :new
  end

  private

  def render_form(survey_form)
    if current_user.mentor?
      render "final_surveys/mentor_form", locals: { survey: survey_form }
    elsif current_user.mentee?
      render "final_surveys/mentee_form", locals: { survey: survey_form }
    end
  end

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
      :mentee_idea_pitch, :mentee_demo_url, :mentee_demo_file, :mentee_recap_and_future, :mentee_feedback
    )
  end

  def mentor_survey_param
    params.require(:mentor_final_survey_form).permit(
      :mentor_impression, :mentor_expectations, :mentor_project_summary, :mentor_feedback,
      :mentor_program_duration
    )
  end

  def clean_survey_params(survey)
    if survey.errors.has_key?(:mentee_demo_file) &&
        survey.errors.values.include?(["file size must be less than 25 MB"])

      survey.mentee_demo_url = ""
      survey.mentee_demo_file = ""
    end

    survey
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
