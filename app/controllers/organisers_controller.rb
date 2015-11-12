class OrganisersController < ApplicationController
   before_action :require_organiser

  def index
    @organisers = User.where(role: 1)
  end

  def require_organiser
    unless current_user && current_user.role =='organizer'
      redirect_to root_path, notice: "Login again as a organiser"
    end
  end
end 
