class MentorProfilesController < UsersController
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
  def setup_project
    @project = Project.find_by(mentor_id: current_user.id)
    @project_symbol = :mentor_project
    @edit_url = edit_mentor_profile_path(current_user)
    @partner_label = "Mentee:"
  end
end
