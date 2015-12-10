class MenteeEvaluationController < ApplicationController
	def index
	    questions = YAML.load_file("#{Rails.root.to_s}/config/mentee_evaluation.yml")
	    application = MenteeApplication.where(id: params['application_id']).first

	    if application['programming_level'] == 'beginner'
	    	questions = questions['beginners']
	    else 
	    	questions = questions['experienced']
	    end

	    locals = { application: application, questions: questions }

	    render locals: {questions: questions, application: application}
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
