class ProjectsController < ApplicationController

  def show
    @project = Project.find(params[:id])
    @week = find_week
    @tasks = @week.nil? ? @project.tasks.not_deleted : @project.week_tasks(@week.number).not_deleted
    @unfinished_tasks = @week.nil? ? @tasks.unfinished(current_user).order(:week) : @project.tasks.for_weeks(@week.number).unfinished(current_user).not_deleted.order(:week)
  end
end
