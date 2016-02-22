class MissingProjectSetupMailer < ApplicationMailer

	def mentor_missing_project_setup(user)
      @mentor = user
      mail(:to => @mentor.email, 
      	:subject=> "[Learn IT, Girl] First week tasks not complete. Action required")
  end

  def mentee_missing_project_setup(user)
      @mentee = user
      mail(:to => @mentee.email, 
      	:subject=> "[Learn IT, Girl] First week tasks not complete. Action required")
  end
end
