class UserRegistrationsController < ApplicationController

  def edit
    @token = params[:id]
    @user = User.find_by(registration_token: params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.find_by(registration_token: params[:id])

    if @user.blank?
      not_authenticated
      return
    end
    if @user.update_attributes(user_params)
      login(@user.email, user_params[:password])
      if @user.mentor?
        redirect_to(dashboard_mentor_profiles_path, :notice => "You've been succesfully added as Mentor.")
      elsif @user.mentee?
        redirect_to(dashboard_mentee_profiles_path, :notice => "You've been successfully added as Scholar.")
      end
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:password).tap do |whitelisted|
      whitelisted[:password_confirmation] = params[:user][:password_confirmation]
      whitelisted[:registration_token] = nil
    end
  end

end
