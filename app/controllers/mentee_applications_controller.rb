class MenteeApplicationsController < ApplicationController

  def new
    @mentee_application = MenteeApplication.new
    #@mentee = MenteeApplication.create(build_step: :personal_information)
    #redirect_to mentee_application_build_path(:personal_information, mentee_application_id: @mentee.id)
  end
end
