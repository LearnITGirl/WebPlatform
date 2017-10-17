class AssignedBadgesController < ApplicationController
  before_action :require_mentee

  def update
    badge = current_user.assigned_badges.find_by(badge_id: params[:badge_id])
    badge.update(displayed: true)
    head :ok
  end
end
