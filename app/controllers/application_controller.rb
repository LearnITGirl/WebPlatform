class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_user_home_page
    redirect_to evaluation_panel_path
    #check the current user type to redirect non-organizers to their dashboard
  end

  def require_organiser
    unless current_user && current_user.organizer?
      redirect_to root_path, alert: "Login again as a organiser!"
    end
  end
end