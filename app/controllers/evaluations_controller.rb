class EvaluationsController < ApplicationController
  before_action :require_organiser, only: [:create_evaluation, :mentor]

  def mentor
    application = MentorApplication.where(id: params['application_id']).first
    return redirect_to dashboard_organisers_path, notice: "Application is being evaluated by another organiser" if different_evaluator(application)

    application.update_column :evaluator_id, current_user.id
    questions = YAML.load_file("#{Rails.root.to_s}/config/mentor_evaluation.yml")
    locals = { application: application, questions: questions }

    render locals: locals
  end

  def mentee
    application = MenteeApplication.where(id: params['application_id']).first
    return redirect_to dashboard_organisers_path, notice: "Application is being evaluated by another organiser" if different_evaluator(application)

    application.update_column :evaluator_id, current_user.id
    questions = YAML.load_file("#{Rails.root.to_s}/config/mentee_evaluation.yml")

    if application.previous_programming_experience
      questions = questions['experienced']
    else
      questions = questions['beginners']
    end

    programming_languages = ProgrammingLanguage.all.map{|pl| [pl.slug, pl.name]}.to_h

    locals = { application: application, questions: questions, programming_languages: programming_languages }

    render locals: locals
  end

  def create_evaluation
    begin
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
    rescue ActiveRecord::RecordInvalid => e
      notice = e.message
    end

    application.update_column :state, 4
    notice ||= "Evaluation finished successfully!"
    redirect_to dashboard_organisers_path, notice: notice
  end

  def skip
    application = params[:type] == "mentor" ?
      MentorApplication.find(params[:application_id]) :
      MenteeApplication.find(params[:application_id])
    application.update_columns(evaluator_id: nil, state: 2)
    redirect_to dashboard_organisers_path, notice: "Application was skipped and will be accessible only by direct URL"
  end

  def reject_mentee
    app = MenteeApplication.find(params[:mentee_application_id])
    app.update(mentee_params)
    redirect_to dashboard_organisers_path, notice: "Application was rejected"
  end

  def reject_mentor
    app = MentorApplication.find(params[:mentor_application_id])
    app.update(mentor_params)
    redirect_to dashboard_organisers_path, notice: "Application was rejected"
  end

  def cancel
    application = params[:type] == "mentor" ?
      MentorApplication.find(params[:application_id]) :
      MenteeApplication.find(params[:application_id])
    application.update_columns(evaluator_id: nil, state: 1)
    redirect_to dashboard_organisers_path, notice: "Application will be available for later evaluation"
  end

  private

  def require_organiser
    unless current_user && current_user.role =='organizer'
      redirect_to root_path, notice: "Login again as an organiser"
    end
  end

  def mentee_params
    params.require(:mentee_application).permit(:state, :rejection_reason).tap do |p|
      p["state"] = p["state"].to_i
    end
  end

  def mentor_params
    params.require(:mentor_application).permit(:state, :rejection_reason).tap do |p|
      p["state"] = p["state"].to_i
    end
  end

  def different_evaluator(app)
    app.evaluator && (app.evaluator != current_user)
  end
end
