class MentorMidtermEvaluationsController < ApplicationController
  before_action :require_mentor, :already_submitted

  def new
    @self_evaluation = MentorMidtermEvaluation.new
  end

  def create
    @self_evaluation = MentorMidtermEvaluation.new(
      evaluation_param.merge({edition_id: current_edition.id, mentor_id: current_user.id})
    )

    if @self_evaluation.save
      redirect_to dashboard_mentor_profiles_path, notice: "Thank you for filling in your midterm self-evaluation!."
    else
      render "new"
    end
  end

  private

  def evaluation_param
    params.require(:mentor_midterm_evaluation).permit(
      :project_progress, :positive_aspects, :future_plans, :weekly_hours,
      :mentee_impression, :extra_info
    )
  end

  def already_submitted
    if current_user.midterm_self_evaluation.present?
      redirect_to dashboard_mentor_profiles_path, notice: "You've already filled in your midterm self-evaluation!."
    end
  end
end
