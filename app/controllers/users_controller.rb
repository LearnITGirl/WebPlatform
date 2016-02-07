class UsersController < ApplicationController
  before_action :require_login
  def show
    authorized_user
    setup_project
  end

  def edit
    authorized_user
    setup_project
  end

  def dashboard
    setup_project
    @partner = current_user.partner
    @week = find_week
    @tasks = @week.nil? ? @project.tasks : @project.week_tasks(@week.number)
  end

  def update
    setup_project
    if current_user.update_attributes(user_params)
      redirect_to mentee_profile_path, notice: "Details have been succesfuly updated."
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
    unless User.find(params[:id]) == current_user
      redirect_to root_path, alert: "You don't have permission to access this site", status: 401
    end
  end
end
