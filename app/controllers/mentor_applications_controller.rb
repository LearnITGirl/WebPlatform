class MentorApplicationsController < ApplicationController

  def new
    @mentor = MentorApplication.create(build_step: :personal_information)
    redirect_to mentor_application_build_path(:personal_information, mentor_application_id: @mentor.id)
  end
end
