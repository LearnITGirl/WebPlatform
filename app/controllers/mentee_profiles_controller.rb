class MenteeProfilesController < ApplicationController
  def show
  end
  def dashboard
  end
  def missing_mentor
      @user = current_user
      @mentor = User.find(matched_id: current_user.matched_id)
      @mentor.is_missing = true
      #@mentor.missing_since = 
      MissingPersonsMailer.MissingMentor(@user).deliver_now
      redirect_to mentee_dashboard_path, notice: 'Organsiers Have been notified about the missing mentor'
      render :nothing => true
      #render :action => "dashboard"
  end
end
