class MenteeProfilesController < UsersController
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
  def setup_project_show
    @project = Project.find_by(mentee_id: params[:id])
    @project_symbol = :mentee_project
    @edit_url = edit_mentee_profile_path(current_user)
    @partner_label = "Mentor:"
  end
  def setup_project
    @project = Project.find_by(mentee_id: current_user.id)
    @project_symbol = :mentee_project
    @edit_url = edit_mentee_profile_path(current_user)
    @partner_label = "Mentor:"
  end
end
