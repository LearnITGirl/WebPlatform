class MenteeApplicationsController < ApplicationController
  def new
    @mentee_application = MenteeApplication.new
  end
end
