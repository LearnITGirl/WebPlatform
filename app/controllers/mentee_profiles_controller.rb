class MenteeProfilesController < ApplicationController
  before_action :require_mentee, except: [ :show ]
  before_action :require_login, only: [:show]

  def show
    @user = User.find(params[:id])
    @mentor = User.find(@user.matched_id)
    @project = Project.find_by(mentee_id: params[:id])
  end
  
  def dashboard
    @mentor = User.find(current_user.matched_id)
    @project = Project.where(mentee_id: current_user.id)

  end
  
  def missing_mentor
    @user = current_user
    @mentor = User.find(current_user.matched_id)
    if @mentor.update_attribute(:is_missing, true)
      MissingPersonsMailer.missing_mentor(@user).deliver_now
      redirect_to dashboard_mentee_profiles_path, notice: 'Organsiers Have been notified about the missing mentor'
    else 
      redirect_to dashboard_mentee_profiles_path, notice: 'Couldnt send mail'
    end
  end
  

end
