class OrganisersRegistrationController < ApplicationController
 before_action :require_organiser
 def create
    @user = User.new(email: params[:email])
    @user.role = params[:role]
    if @user.save
       OrganisersMailer.organisers_add_email(@user).deliver_now
       redirect_to organisers_path, notice: 'Instructions have been sent to the email'
    else
       flash.now[:alert] = @user.errors.full_messages.join(", ")
       display_organisers
       render "/organsiers/index"

    end
  end

  def edit
    @token = params[:id]
    @user = User.find_by(organiser_token: params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end
  def update
    @token = params[:id]
    @user = User.find_by(organiser_token: params[:id])

    if @user.blank?
      not_authenticated
      return
    end
    @user.role = 1
    if @user.update_attributes(user_params)
      redirect_to(organisers_path, :notice => 'Succesfully added as organiser.')
    else
      render :action => "edit"
    end
  end
  private
  def require_organiser
    unless current_user && current_user.role =='organizer'
      redirect_to root_path, notice: "Login again as a organiser"
    end
  end
  def user_params
      params.require(:user).permit(:first_name,:last_name,:country, :password, :password_confirmation)
  end
  def display_organisers
    @organisers = User.where(role: 1)
  end


end
