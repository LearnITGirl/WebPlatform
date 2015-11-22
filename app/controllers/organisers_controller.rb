class OrganisersController < ApplicationController
   before_action :require_organiser

  def index
    display_organisers
  end
  
  def create
  end
  def edit
  end
  def update
  end
  
  private
  def require_organiser
    unless current_user && current_user.role =='organizer'
      redirect_to root_path, notice: "Login again as a organiser"
    end
  end
  def display_organisers
    @organisers = User.where(role: 1)
  end
end 
