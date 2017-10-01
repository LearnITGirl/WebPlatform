class SkippedApplicationsController < ApplicationController
  before_action :require_organiser

  def index
    locals={
      mentors: MentorApplication.skipped,
      mentees: MenteeApplication.skipped,
    }
    render 'index', locals: locals
  end
end
