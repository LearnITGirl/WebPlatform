class UserSessionsController < ApplicationController
  skip_before_action :require_login, raise: false, except: [:destroy]

  def new
   @user = User.new
  end

  def create
    if @user = login(params[:session][:email].downcase, params[:session][:password])
      check_partner
    else
      flash.now[:alert] = "Email and password don't match"
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "Logged out!"
  end

  private

  def user_dashboard_path
    case current_user.role
    when "mentee" then dashboard_mentee_profiles_path
    when "organizer" then dashboard_organisers_path
    else dashboard_mentor_profiles_path
    end
  end

  def check_partner
    if @user.role == "organizer"
      redirect_to user_dashboard_path, notice: "Login Succesful!"
    elsif current_edition.end_date < DateTime.current
      logout
      redirect_to root_path, notice: "Current edition has ended. Please send email to learnitgirl.office@gmail.com with any inquiries"
    elsif (@user.role != "organizer" && @user.project.present? && @user.partner.present?)
      redirect_to user_dashboard_path, notice: "Login Succesful!"
    else
      logout
      redirect_to root_path, notice: "You currently have no mentor/mentee assigned - please wait until LITG organizer contacts you before accessing the platform again."
    end
  end

  def check_role
    if @user.role == "organizer"
      redirect_to dashboard_organisers_path, notice: "Login Succesful!"
    else
      logout
      redirect_to root_path, notice: "Current edition has already ended!"
    end
  end
end
