class UsersController < ApplicationController
  before_action :require_login

  def show
    authorized_user
    @user = User.find(params[:id])
    setup_project(@user)
  end

  def edit
    authorized_user
    setup_project(current_user)
  end

  def dashboard
    setup_project(current_user)
    @partner = current_user.partner
    @week = find_week
    @tasks = @week.nil? ? @project.tasks.not_deleted : @project.week_tasks(@week.number).not_deleted
  end

  def update
    setup_project(current_user)

    if current_user.update_attributes(user_params)
      redirect_to @after_update_path, notice: "Details have been succesfuly updated."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :country, :program_country, :timezone, :avatar,
      :mentee_project_attributes => [:id, :title,:description,:github_link]
    )
  end

  def authorized_user
    unless User.find(params[:id]) == current_user || current_user.organizer? || current_user.partner.id == params[:id].to_i
      redirect_to root_path, alert: "You don't have permission to access this site", status: 401
    end
  end
end
