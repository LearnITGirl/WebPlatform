class MentorApplicationsController < ApplicationController
  before_action :redirect_for_closed_registration

  def new
    @mentor_application = MentorApplication.new.attributes
    @mentor_application[:programming_languages] = []
  end
end
