class MenteeApplicationsController < ApplicationController
  before_action :redirect_for_closed_registration

  def new
    @mentee_application = MenteeApplication.new
  end
end
