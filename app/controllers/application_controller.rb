class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_edition

  def current_edition
    Edition.find_by(name: "second")
  end

  def get_user_home_page
    redirect_to evaluation_panel_path
    #check the current user type to redirect non-organizers to their dashboard
  end

  def require_organiser
    unless current_user && current_user.organizer?
      redirect_to root_path, alert: "Login again as a organiser!"
    end
  end

  def require_mentee
    unless current_user && current_user.mentee?
      redirect_to root_path, alert: "Login again as mentee!"
    end
  end

  def require_mentor
    unless current_user && current_user.mentor?
      redirect_to root_path, alert: "Login again as mentor!"
    end
  end

  def check_midterm_self_evaluation
    if current_user && !current_user.organizer? && current_user.midterm_self_evaluation.blank?
      url = current_user.mentor? ? new_mentor_midterm_evaluations_path : new_mentee_midterm_evaluations_path
      text = "You haven't filled in your midterm survey. Please click #{view_context.link_to('here', url)}"
      flash.now[:warning] = text unless request.original_url.match "^#{request.base_url}/#{current_user.role}.midterm_evaluations"
    end
  end

  def find_week
    if params[:week] == "all"
      nil
    elsif params[:week].present?
      current_edition.weeks.find_by(number: params[:week])
    else
      current_edition.weeks.find_by(start: (Time.zone.now).beginning_of_week)
    end
  end
end
