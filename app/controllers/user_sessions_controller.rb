class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  def new
   @user = User.new
  end

  def create
    if @user = login(params[:session][:email].downcase, params[:session][:password])
      redirect_to user_dashboard_path, notice: "Login Succesful!"
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
    else root_path #we also don't have mentor dashboard yet
    end
  end
end
