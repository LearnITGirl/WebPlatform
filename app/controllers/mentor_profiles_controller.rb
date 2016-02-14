class MentorProfilesController < ApplicationController
  before_action :require_mentor, except: [ :show ]
  before_action :require_login, only: [:show]

  def dashboard
    @partner = current_user.partner
    @project = Project.find_by(mentor_id: current_user.id)
    @week = find_week
    @tasks = @week.nil? ? @project.tasks : @project.week_tasks(@week.number)
  end

  def show
    @mentor = User.find(params[:id])
    @mentee = @mentor.partner
    @project = Project.find_by(mentor_id: params[:id])
  end

  def missing_mentee
    @user = current_user
    @mentee = current_user.partner
    if @mentee.update_attributes(is_missing: true, missing_since: DateTime.now)
      MissingPersonsMailer.missing_mentee(@user).deliver_now
      redirect_to dashboard_mentor_profiles_path, notice: 'Organsiers Have been notified about the missing mentee'
    else
      redirect_to dashboard_mentor_profiles_path, notice: 'Couldnt send mail'
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :country, :program_country, :timezone, :avatar,
      :mentor_project_attributes => [:id, :title,:description,:github_link]
    )
  end

  def setup_project(user)
    @project = Project.find_by(mentor_id: user.id)
    @project_symbol = :mentor_project
    @edit_url = edit_mentor_profile_path(user)
    @after_update_path = mentor_profile_path(user)
    @partner_label = "Mentee:"
  end
end
