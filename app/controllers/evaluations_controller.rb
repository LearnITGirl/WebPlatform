class EvaluationsController < ApplicationController
  before_action :require_organiser, only: [:create_evaluation, :mentor]

  def mentor
    questions = YAML.load_file("#{Rails.root.to_s}/config/mentor_evaluation.yml")
    application = MentorApplication.where(id: params['application_id']).first

    locals = { application: application, questions: questions }

    render locals: locals
  end

  def mentee
    questions = YAML.load_file("#{Rails.root.to_s}/config/mentee_evaluation.yml")
    application = MenteeApplication.where(id: params['application_id']).first

    if application['programming_level'] == 'beginner'
      questions = questions['beginners']
    else
      questions = questions['experienced']
    end

    locals = { application: application, questions: questions }

    render locals: locals
  end

  def create_evaluation
    if params[:mentor_application_id].present?
      application = MentorApplication.find(params[:mentor_application_id])
      MentorApplicationEvaluation.new(evaluation: params['evaluation'],
                                    user: current_user,
                                    application: application).evaluate
    elsif params[:mentee_application_id].present?
      application = MenteeApplication.find(params[:mentee_application_id])
      MenteeApplicationEvaluation.new(evaluation: params['evaluation'],
                                    user: current_user,
                                    application: application,
	                                  max_soundness: params[:max_soundness]).evaluate
    end

    redirect_to root_path, notice: "Evaluation finished successfully!"
  end

  private

  def require_organiser
    unless current_user && current_user.role =='organizer'
      redirect_to root_path, notice: "Login again as a organiser"
    end
  end
end
