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
      redirect_to(dashboard_mentor_profiles_path, :notice => "You've been succesfully added as Mentor.")
    else
      render :action => "edit"
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
