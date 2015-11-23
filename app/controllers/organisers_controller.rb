class OrganisersController < ApplicationController
   before_action :require_organiser

  def index
    display_organisers
    organisers_left
  end
  
  def create
    @user = User.new(email: params[:email], role:1)
    if @user.save
       OrganisersMailer.organisers_add_email(@user).deliver_now
       redirect_to organisers_path, notice: 'Instructions have been sent to the email'
    else
       flash.now[:alert] = @user.errors.full_messages.join(", ")
       display_organisers
       organisers_left
       render "index"

    end
  end
  private
  def require_organiser
    unless current_user && current_user.role =='organizer'
      redirect_to root_path, notice: "Login again as a organiser"
    end
  end
  def display_organisers
    @organisers = User.where(role: 1, organiser_token:nil)
  end
  def organisers_left
    @pending_organisers = User.where(role: 1).where.not(organiser_token: nil)
  end
end 
