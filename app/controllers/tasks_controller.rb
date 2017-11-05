class TasksController < ApplicationController

  after_action :award_novice_badge

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
      @unfinished_tasks = @week.nil? ? @tasks.unfinished(current_user) : @project.tasks.for_weeks(@week.number).unfinished(current_user).not_deleted.order(:id) + @tasks.not_done.order(:id)
      render (current_user.mentee? ? "users/dashboard" : "mentor_profiles/dashboard")
    end
  end

  def edit
    @task = Task.find(params[:id])
    @week = current_edition.weeks.find_by(number: @task.week) || find_week
    render partial: 'edit_modal', layout: false
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes task_params
      request.xhr? ? (head :ok) : (redirect_to dashboard_path)
    else
      render json: {msg: @task.errors.full_messages.join(',')}, status: 422
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.update_columns deleted_at: DateTime.current, status: 5
    redirect_to :back, notice: "Deleted successfully!"
  end

  def accept
    @task = Task.find(params[:id])
    @task.update_columns status: 3, week: find_week.number
    redirect_to dashboard_path
  end

  private

  def task_params
    params.require(:task).permit(:status, :title).tap do |task|
      if task[:status].present?
        task[:status] = Task.statuses[task["status"]]
        task[:finished_by] = current_user.id
      end
    end
  end

  def dashboard_path
    current_user.mentee? ? dashboard_mentee_profiles_path(week: @task.week) : dashboard_mentor_profiles_path(week: @task.week)
  end

  def award_novice_badge
      if @task.project.tasks.finished(current_user).count >= 1
           assign_novice_badge
      else unassign_novice_badge
      end
  end

  def assign_novice_badge
    unless @task.project.mentee.badges.novice.any?
       @task.project.mentee.badges << Badge.novice
    end
  end

  def unassign_novice_badge
    unless @task.project.mentee.badges.novice.any?
       @task.project.mentee.badges.delete(Badge.novice)
    end
  end

end
