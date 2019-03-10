class RoadmapsController < ApplicationController
  before_action :require_login

  def new

  end

  def show
    authorized_user
    @project = Project.find(params[:project_id])
  end

  def authorized_user
    unless current_user.organizer? || current_user.project.id == params[:project_id].to_i
      redirect_to root_path, alert: "You don't have permission to access this site", status: 401
    end
  end
end
