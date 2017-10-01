class MenteeApplicationsController < ApplicationController
  before_action :registration_open?

  def new
    @mentee_application = MenteeApplication.new
  end
end
