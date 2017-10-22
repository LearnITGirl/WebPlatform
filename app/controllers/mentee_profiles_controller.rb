class MenteeProfilesController < UsersController

  def missing_mentor
    @user = current_user
    @mentor = current_user.partner

    if @mentor.update_attributes(is_missing: true, missing_since: DateTime.current)
      MissingPersonsMailer.missing_mentor(@user).deliver_now
      send_email_to_missing_mentor
      redirect_to dashboard_mentee_profiles_path, notice: 'Organsiers have been notified about the missing mentor'
    else
      redirect_to dashboard_mentee_profiles_path, notice: 'Failed to send email'
    end
  end

  private

  def setup_project
    @project = Project.find_by(mentee_id: current_user.id)
    @project_symbol = :mentee_project
    @edit_url = edit_mentee_profile_path(current_user)
    @partner_label = "Mentor:"
  end

  def setup_project(user)
    @project = Project.find_by(mentee_id: user.id)
    @project_symbol = :mentee_project
    @edit_url = edit_mentee_profile_path(user)
    @after_update_path = mentee_profile_path(user)
    @partner_label = "Mentor:"
  end
  def send_email_to_missing_mentor
    email_template = EmailTemplate.find_by(recipients: 5)
    EmailTemplateMailer.custom(email_template, current_user.partner).deliver_now
  end

end
