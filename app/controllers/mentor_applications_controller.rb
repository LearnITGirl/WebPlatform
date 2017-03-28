class MentorApplicationsController < ApplicationController
  def new
    @mentor_application = MentorApplication.new
  end
end
