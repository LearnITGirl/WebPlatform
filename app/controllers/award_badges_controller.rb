class AwardBadgesController < ApplicationController

  def index
	@projects = Project.where.not(mentee_id: Badge.where(name: [11]).includes(:users).map{|b| b.users.pluck(:id)}.flatten)
  end

  def create 
	assign_visionary_badge
	#redirect_to award_badges_path
	render "index"
  end

   def assign_visionary_badge
      unless @project.mentee.badges.visionary.any?
        @project.mentee.badges << Badge.visionary
      end
   end

   def assign_organized_badge
      unless @project.mentee.badges.organized.any?
        @project.mentee.badges << Badge.organized
      end
   end

end
