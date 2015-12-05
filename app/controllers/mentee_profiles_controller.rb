class MenteeProfilesController < ApplicationController
  def show
  end
  def dashboard
  end
  def missing_mentor
      @user = current_user
      @mentor = User.find_by_id (current_user.matched_id)
      if @mentor.update_attribute(:is_missing, true)
      	MissingPersonsMailer.MissingMentor(@user).deliver_now
      	redirect_to mentee_dashboard_path, notice: 'Organsiers Have been notified about the missing mentor'
      else 
         flash.now[:alert] = "couldnt update"
      	 redirect_to mentee_dashboard_path, notice: 'failed'
      end
  end
end
