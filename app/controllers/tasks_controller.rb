class TasksController < ApplicationController

  def create
    @project = current_user.project
    @partner = current_user.partner

    @task = @project.tasks.new(
      title: params[:task][:title], creator_id: current_user.id,
      status: 1, week: params[:task][:week]
    )

    if @task.save
      redirect_to (current_user.mentee? ? dashboard_mentee_profiles_path(week: @task.week) : dashboard_mentor_profiles_path(week: @task.week))
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
    params.require(:task).permit(:status, :week).tap do |task|
      task[:status] = Task.statuses[task["status"]]
      task[:finished_by] = current_user.id
    end
  end
end
