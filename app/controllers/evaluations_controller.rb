class EvaluationsController < ApplicationController

  def mentor
    questions = YAML.load_file("#{Rails.root.to_s}/config/mentor_evaluation.yml")
    application = MentorApplication.where(id: params['application_id']).first

    locals = { application: application, questions: questions}

    render locals: locals
  end
end
