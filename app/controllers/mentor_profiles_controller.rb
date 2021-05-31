class MentorProfilesController < UsersController

  def missing_mentee
    @user = current_user
    @mentee = current_user.partner
    if @mentee.update(is_missing: true, missing_since: DateTime.current)
      MissingPersonsMailer.missing_mentee(@user).deliver_now
      send_email_to_missing_mentee
      redirect_to dashboard_mentor_profiles_path, notice: 'Organsiers have been notified about the missing mentee'
    else
      redirect_to dashboard_mentor_profiles_path, notice: 'Failed to send email'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :country, :program_country, :timezone, :avatar,
      :mentor_project_attributes => [:id, :title,:description,:github_link, :current_user_role]
    )
  end

  def setup_project(user)
    @project = Project.find_by(mentor_id: user.id)
    @project_symbol = :mentor_project
    @edit_url = edit_mentor_profile_path(user)
    @after_update_path = mentor_profile_path(user)
    @partner_label = "Mentee:"
  end
  
  def send_email_to_missing_mentee
    email_template = EmailTemplate.find_by(recipients: 4)
    EmailTemplateMailer.custom(email_template, current_user.partner).deliver_now
  end
end
