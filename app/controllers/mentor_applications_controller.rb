class MentorApplicationsController < ApplicationController
  def new
    @mentor_application = MentorApplication.new.attributes
    @mentor_application[:programming_languages] = []
  end
end
