class MenteeMidtermEvaluationsController < ApplicationController
  before_action :require_mentee, :already_submitted

  def new
    @self_evaluation = MenteeMidtermEvaluation.new
  end

  def create
    @self_evaluation = MenteeMidtermEvaluation.new(
      evaluation_param.merge({edition_id: current_edition.id, mentee_id: current_user.id, project_id: current_user.project.id})
    )

    if @self_evaluation.save
      current_user.project.update_attribute(:mentee_midterm_evaluation_id, @self_evaluation.id)

      redirect_to dashboard_mentee_profiles_path, notice: "Thank you for filling in your midterm self-evaluation!."
    else
      render "new"
    end
  end

  private

  def evaluation_param
    params.require(:mentee_midterm_evaluation).permit(
      :project_progress, :language_progress, :positive_aspects, :future_plans, :weekly_hours,
      :mentor_impression, :extra_info
    )
  end

  def already_submitted
    if current_user.midterm_self_evaluation.present?
      redirect_to dashboard_mentee_profiles_path, notice: "You've already filled in your midterm self-evaluation!"
    end
  end
end
