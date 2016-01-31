class MentorProfilesController < ApplicationController
  before_action :require_mentor, except: [ :show ]
  before_action :require_login, only: [:show]

  def dashboard
    @mentee = current_user.partner
    @project = Project.find_by(mentor_id: current_user.id)
  end

  def show
    @mentor = User.find(params[:id])
    @mentee = @mentor.partner
    @project = Project.find_by(mentor_id: params[:id])
  end

  def missing_mentee
    @user = current_user
    @mentee = current_user.partner
    if @mentee.update_attribute(:is_missing, true)
      MissingPersonsMailer.missing_mentee(@user).deliver_now
      redirect_to dashboard_mentor_profiles_path, notice: 'Organsiers Have been notified about the missing mentee'
    else
      redirect_to dashboard_mentor_profiles_path, notice: 'Couldnt send mail'
    end
  end

end
