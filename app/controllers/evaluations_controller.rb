class EvaluationsController < ApplicationController
  def mentor
    questions = YAML.load_file("#{Rails.root.to_s}/config/mentor_evaluation.yml")
    application = MentorApplication.where(id: params['application_id']).first

    locals = { application: application, questions: questions }

    render locals: locals
  end

  def create_evaluation
    if params[:mentor_application_id].present?
      application = MentorApplication.find(params[:mentor_application_id])
      MentorApplicationEvaluation.new(evaluation: params['evaluation'],
                                    user: current_user,
                                    application: application).evaluate
    end

    redirect_to root_url
  end
end
