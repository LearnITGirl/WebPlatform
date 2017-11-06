class UsersController < ApplicationController
  before_action :require_login

  def show
    authorized_user
    @user = User.find(params[:id])
    find_new_badge
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
    @unfinished_tasks = @week.nil? ? @tasks.unfinished(current_user).order(:week) : @project.tasks.for_weeks(@week.number).unfinished(current_user).not_deleted.order(:week)
    find_new_badge
  end

  def update
    setup_project(current_user)

    if current_user.update_attributes(user_params)
      redirect_to @after_update_path, notice: "Details have been succesfuly updated."
    else
      render "edit"
    end
  end

  def user_status
    @user = User.find(params[:mentee_profile_id].to_i) || User.find(params[:mentor_profile_id].to_i)
    date = DateTime.strptime(params[:user][:warning_email_date], "%Y-%m-%d") if params[:user][:warning_email_date].present?

    if @user && params[:user][:warning_email_date].present? && @user.update_attribute(:send_warning_email_after, date + 1.week)
      flash[:notice] = 'User details updated successfully - 1 week was added for the pair to catch up'
    else
      flash[:alert] = "User or Date invalid"
    end
    redirect_to :back
  end

  def report_resignation
    authorized_user
    user = User.find(params[:id])

    UserResignation.new(user: user).proceed(reason: params[:reason])

    redirect_to mentor_to_mentee_matchers_path
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

  def find_new_badge
    if current_user.mentee?
      @new_badge = current_user.undisplayed_badges.first
      return unless @new_badge.present?
      assigned_badge = current_user.assigned_badges.where(badge_id: @new_badge.id).last
      @upgrade_from_badge = Badge.find_by(id: assigned_badge.upgraded_from) if assigned_badge.present?
    end
  end
end
