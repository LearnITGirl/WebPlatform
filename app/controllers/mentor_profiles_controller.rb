class MentorProfilesController < ApplicationController
  before_action :require_mentor, except: [ :show ]
  before_action :require_login, only: [:show]

  def dashboard
    @mentee = User.find(current_user.matched_id)
    @project = Project.find_by(mentor_id: current_user.id)
  end

  def show
    @mentor = User.find(params[:id])
    @mentee = User.find(@mentor.matched_id)
    @project = Project.find_by(mentor_id: params[:id])
  end

  def missing_mentee
    @user = current_user
    @mentee = User.find(current_user.matched_id)
    if @mentee.update_attribute(:is_missing, true)
      MissingPersonsMailer.missing_mentee(@user).deliver_now
      redirect_to dashboard_mentor_profiles_path, notice: 'Organsiers Have been notified about the missing mentee'
    else
      redirect_to dashboard_mentor_profiles_path, notice: 'Couldnt send mail'
    end
  end

end
