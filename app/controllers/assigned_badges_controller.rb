class AssignedBadgesController < ApplicationController
  before_action :require_mentee

  def update
    badge = current_user.assigned_badges.where(badge_id: params[:badge_id]).last
    badge.update(displayed: true)
    head :ok
  end
end
