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

  def update
    @task = Task.find(params[:id])
    @task.update_attributes task_params
    redirect_to :back
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to dashboard_mentee_profiles_path, notice: "Deleted successfully!"
  end

  def accept
    @task = Task.find(params[:id])
    @task.update_column :status, 3
    redirect_to :back
  end

  private

  def task_params
    params.require(:task).permit(:status).tap do |task|
      task[:status] = Task.statuses[task["status"]]
    end
  end
end
