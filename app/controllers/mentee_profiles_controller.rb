class MenteeProfilesController < ApplicationController
  def show

  end
  def dashboard

  end
  def missing_mentor
    @user = current_user
    if !@user.blank? 
      @mentor = User.find_by(id: current_user.matched_id)
      if @mentor.update_attribute(:is_missing, true)
        MissingPersonsMailer.missing_mentor(@user).deliver_now
      	redirect_to dashboard_mentee_profiles_path, notice: 'Organsiers Have been notified about the missing mentor'
      else 
      	 redirect_to dashboard_mentee_profiles_path, notice: 'Couldnt send mail'
      end
    else 
      redirect_to dashboard_mentee_profiles_path, notice: "Please login first"
    end
  end
end
