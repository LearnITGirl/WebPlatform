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

	def create
		Rails.logger.info("PARAMS: #{params.inspect}")
	    if params[:mentee_application_id].present?
	      application = MenteeApplication.find(params[:mentee_application_id])
		Rails.logger.info("SOUNDNESS: #{@max_soundness}")

	      MenteeApplicationEvaluation.new(evaluation: params['evaluation'],
	                                    user: current_user,
	                                    application: application,
	                                    max_soundness: params[:max_soundness]).evaluate
	    end

	    redirect_to root_url
	 end
end
