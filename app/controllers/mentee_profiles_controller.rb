class MenteeProfilesController < ApplicationController
  before_action :require_mentee, except: [ :show ]
  before_action :require_mentee_or_organiser, only: [:show]

  def show
    @user = User.find(params[:id])
    @mentor = User.find(@user.matched_id)
  end
  
  def dashboard
    @mentor = User.find(current_user.matched_id)
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
  
  private
   def require_mentee
    unless current_user && current_user.mentee?
      redirect_to root_path, alert: "Login again as a Mentee!"
    end
   end

   def require_mentee_or_organiser
    unless current_user && (current_user.organizer? || current_user.mentee?)
      redirect_to root_path, alert: "You're not authorized to access this page!"
    end
   end

end
