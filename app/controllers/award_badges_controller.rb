class AwardBadgesController < ApplicationController

  def index
    @projects = Project.where.not(mentee_id: Badge.where(name: [11]).includes(:users).map{|b| b.users.pluck(:id)}.flatten)
  end

  def create 
    @curr_project = Project.find(params[:proj_id])
    assign_visionary_badge
    redirect_to award_badges_path
  end


  def assign_visionary_badge
      unless @curr_project.mentee.badges.visionary.any?
        @curr_project.mentee.badges << Badge.visionary
      end
  end

end
