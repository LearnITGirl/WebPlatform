class OrganisersController < ApplicationController
   before_action :require_organiser

  def index
    @organisers = User.where(role: 1)
  end
  

  def create
    @user = User.find_by(email: params[:email])
    if @user.blank? || (@user.role != "organizer")
       OrganisersMailer.organisers_add_email(params[:email]).deliver_now
       redirect_to organisers_path, notice: 'Instructions have been sent to the email'
    else
       flash.now[:alert] = "User exist"
       #render "index"
    end
  end
  def edit

  end

  def require_organiser
    unless current_user && current_user.role =='organizer'
      redirect_to root_path, notice: "Login again as a organiser"
    end
  end
end 
