class TasksController < ApplicationController
 
  def create
    @mentor = User.find(current_user.matched_id)
    @project = Project.find_by(mentee_id: current_user.id)
   
    @task = Task.new(title: params[:title], creator_id: current_user.id, created_at: DateTime.now, status: 1, project_id: @project.id)

    if @task.save
      redirect_to dashboard_mentee_profiles_path, notice: "Task added succesfully"
    else
      flash.now[:alert] = @task.errors.full_messages.join(", ")
      redirect_to dashboard_mentee_profiles_path
    end

  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy   
    redirect_to dashboard_mentee_profiles_path, notice: "Deleted successfully!"   
  end

  def index
  end
end
