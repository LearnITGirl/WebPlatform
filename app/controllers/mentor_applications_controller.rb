class MentorApplicationsController < ApplicationController
  before_action :registration_open?

  def new
    @mentor_application = MentorApplication.new.attributes
    @mentor_application[:programming_languages] = []
  end
end
