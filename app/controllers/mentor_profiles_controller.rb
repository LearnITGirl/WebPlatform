class MentorProfilesController < UsersController

  def missing_mentee
    @user = current_user
    @mentee = current_user.partner
    if @mentee.update_attributes(is_missing: true, missing_since: DateTime.now)
      MissingPersonsMailer.missing_mentee(@user).deliver_now
      send_email_to_missing_mentee
      redirect_to dashboard_mentor_profiles_path, notice: 'Organsiers Have been notified about the missing mentee'
    else
      redirect_to dashboard_mentor_profiles_path, notice: 'Couldnt send mail'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :country, :program_country, :timezone, :avatar,
      :mentor_project_attributes => [:id, :title,:description,:github_link]
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
