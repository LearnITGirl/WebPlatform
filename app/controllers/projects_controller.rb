class ProjectsController < ApplicationController

	def show
		@project = Project.find(params[:id])
		@week = find_week
		@tasks = @week.nil? ? @project.tasks.not_deleted : @project.week_tasks(@week.number).not_deleted
	end
end
