class MidtermEvaluationsController < ApplicationController

	def evaluate_project
		@project = Project.find(params[:project_id])
		@mentee_midterm_evaluation = @project.mentee.mentee_midterm_evaluation
		@mentor_midterm_evaluation = @project.mentor.mentor_midterm_evaluation
		@mentee_final_survey = @project.mentee.mentee_final_survey
		@mentor_final_survey = @project.mentor.mentor_final_survey

		if @project.mentor.email.split('+mentor').join == current_user.email
			redirect_to dashboard_organisers_path, notice: "You can't evaluate yourself! Let others do it for you :)"
		elsif @project.midterm_evaluation_completed?
			redirect_to dashboard_organisers_path, notice: "Midterm Application for this project has already been filled"
		end
	end

	def update_project
		@project = Project.find(params[:project_id])
		if @project.midterm_evaluation_completed?
			redirect_to dashboard_organisers_path, notice: "Midterm Application for this project has already been filled"
		elsif @project.update_attributes(evaluation_params)
			@project.update_attribute(:midterm_evaluation_status, 2)
			redirect_to dashboard_organisers_path, notice: "Midterm Evaluation submitted successfully!"
		else
			flash[:alert] = @project.errors.full_messages.join(", ")
			redirect_to action: 'evaluate_project'
		end
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

end
