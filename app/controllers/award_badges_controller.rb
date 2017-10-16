class AwardBadgesController < ApplicationController

  before_action :require_organiser
   
  def index
    @projects = Project.where.not(mentee_id: Badge.visionary.joins(:users).uniq.pluck("users.id"))
  end

  def create
    @project = Project.find(params[:id])
    assign_visionary_badge
    redirect_to award_badges_path
  end

  private

  def assign_visionary_badge
    unless @project.mentee.badges.visionary.any?
      @project.mentee.badges << Badge.visionary
    end
  end

end
