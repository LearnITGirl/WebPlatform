class RoadmapsController < ApplicationController
  before_action :require_login

  def edit
    authorized_user
    if current_user.mentee?
      @project = Project.find(params[:project_id])
    else
      redirect_to root_path, alert: "You don't have permission to access this site", status: 401
    end
  end

  def update
    authorized_user
    @project = Project.find(params[:project_id])
    if @project.update_attributes(roadmap_params)
      unless @project.mentee.badges.organized.any?
        @project.mentee.badges << Badge.organized
      end

      redirect_to project_roadmap_path(@project)
    else
      render "edit"
    end
  end

  def show
    authorized_user
    @project = Project.find(params[:project_id])
  end

  private

  def authorized_user
    unless current_user.organizer? || current_user.project.id == params[:project_id].to_i
      redirect_to root_path, alert: "You don't have permission to access this site", status: 401
    end
  end

  def roadmap_params
    params.require(:project).permit(
      :roadmap_entries_attributes => [:id, :edition_id, :week_id, :content]
    )
  end
end
