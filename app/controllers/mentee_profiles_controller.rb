class MenteeProfilesController < ApplicationController
  before_action :require_mentee, except: [ :show ]
  before_action :require_login, only: [:show]

  def show
    @mentee = User.find(params[:id])
    @mentor = @mentee.partner
    @project = Project.find_by(mentee_id: params[:id])
  end

  def dashboard
    @partner = current_user.partner
    @project = Project.find_by(mentee_id: current_user.id)
    @week = find_week
    @tasks = @week.nil? ? @project.tasks : @project.week_tasks(@week.number)
  end

  def edit
    @project = Project.find_by(mentee_id: current_user.id)
  end

  def update
    @project = Project.find_by(mentee_id: current_user.id)

    if current_user.update_attributes(user_params)
      redirect_to mentee_profile_path, notice: "Details have been succesfuly updated."
    else
      render "edit"
    end
  end

  def missing_mentor
    @user = current_user
    @mentor = current_user.partner
    if @mentor.update_attributes(is_missing: true, missing_since: DateTime.now)
      MissingPersonsMailer.missing_mentor(@user).deliver_now
      redirect_to dashboard_mentee_profiles_path, notice: 'Organsiers Have been notified about the missing mentor'
    else
      redirect_to dashboard_mentee_profiles_path, notice: 'Couldnt send mail'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :country, :program_country, :timezone, :avatar,
      :mentee_project_attributes => [:id, :title,:language,:description,:github_link]
    )
  end

  def setup_project(user)
    @project = Project.find_by(mentee_id: user.id)
    @project_symbol = :mentee_project
    @edit_url = edit_mentee_profile_path(user)
    @after_update_path = mentee_profile_path(user)
    @partner_label = "Mentor:"
  end
end
