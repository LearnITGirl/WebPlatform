class TasksController < ApplicationController

  def create
    @project = current_user.project
    @partner = current_user.partner

    @task = @project.tasks.new(
      title: params[:task][:title], creator_id: current_user.id,
      status: 1, week: params[:task][:week]
    )

    if @task.save
      redirect_to dashboard_path
    else
      @week = find_week
      @tasks = @week.nil? ? @project.tasks.not_deleted : @project.week_tasks(@week.number).not_deleted
      render (current_user.mentee? ? "users/dashboard" : "mentor_profiles/dashboard")
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes task_params
    request.xhr? ? (head :ok) : (redirect_to dashboard_path)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.update_columns deleted_at: DateTime.now, status: 5
    redirect_to :back, notice: "Deleted successfully!"
  end

  def accept
    @task = Task.find(params[:id])
    @task.update_columns status: 3, week: find_week.number
    redirect_to dashboard_path
  end

  private

  def task_params
    params.require(:task).permit(:status, :week).tap do |task|
      task[:status] = Task.statuses[task["status"]]
      task[:finished_by] = current_user.id
      task[:week] = find_week.number
    end
  end

  def dashboard_path
    current_user.mentee? ? dashboard_mentee_profiles_path(week: @task.week) : dashboard_mentor_profiles_path(week: @task.week)
  end
end
