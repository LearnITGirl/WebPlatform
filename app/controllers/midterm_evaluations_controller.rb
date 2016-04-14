class MidtermEvaluationsController < ApplicationController
  before_action :require_organiser

  def index
    @projects = Project.where.not(mentee_midterm_evaluation_id: nil, mentee_midterm_evaluation_id: nil, mentor_id: current_user.id)
                          .where(midterm_evaluation_completed: false)
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params.merge({midterm_evaluation_completed: true}))
      redirect_to midterm_evaluations_path, notice: "Project successfully evaluated."
    else
      render :edit
    end
  end

  private

  def project_params
    params.require(:project).permit(:mentor_evaluation, :mentor_work_is_as_he_described, :how_is_mentee_doing, :github_evaluation)
  end
end
