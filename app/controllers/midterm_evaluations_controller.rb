class MidtermEvaluationsController < ApplicationController

  def edit
    prepare_data

    if @project.mentor.email.split('+mentor').join == current_user.email
      redirect_to dashboard_organisers_path, notice: "You can't evaluate yourself! Let others do it for you :)"
    elsif @project.midterm_evaluation_completed?
      redirect_to dashboard_organisers_path, notice: "Midterm Application for this project has already been filled"
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.midterm_evaluation_completed?
      redirect_to dashboard_organisers_path, notice: "Midterm Application for this project has already been filled"
    elsif @project.update(evaluation_params)
      @project.update(:midterm_evaluation_status, 2)
      redirect_to dashboard_organisers_path, notice: "Evaluation submitted successfully!"
    else
      flash.now[:alert] = @project.errors.full_messages.join(", ")
      render "edit"
    end
  end

  def show
    prepare_data
  end

  private

  def evaluation_params
    params.require(:project).permit(
      :mentor_evaluation, :mentee_feedback, :mentee_project_status, :github_repo_status
    ).tap do |param|
      param.map{|key, value| param[key] = value.to_i if value.present?}
      param[:midterm_evaluation_status] = 1
    end
  end

  def prepare_data
    @project = Project.find(params[:id])
    @mentee_midterm_evaluation = @project.mentee.mentee_midterm_evaluation
    @mentor_midterm_evaluation = @project.mentor.mentor_midterm_evaluation
    @mentee_final_survey = @project.mentee.mentee_final_survey
    @mentor_final_survey = @project.mentor.mentor_final_survey
  end

end
