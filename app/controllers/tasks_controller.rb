class TasksController < ApplicationController

  def create
    @project = current_user.project
    current_user.mentee? ? (@mentor = @project.mentor) : (@mentee = @project.mentee)

    @task = @project.tasks.new(title: params[:task][:title], creator_id: current_user.id, status: 1)

    if @task.save
      redirect_to (current_user.mentee? ? dashboard_mentee_profiles_path : dashboard_mentor_profiles_path)
    else
      render (current_user.mentee? ? "mentee_profiles/dashboard" : "mentor_profiles/dashboard")
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to dashboard_mentee_profiles_path, notice: "Deleted successfully!"
  end
end
