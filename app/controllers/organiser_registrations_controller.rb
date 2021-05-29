class OrganiserRegistrationsController < ApplicationController

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
    @user.organiser_token = nil
    if @user.update(user_params)
      login(@user.email, user_params[:password])
      redirect_to(organisers_path, :notice => "You've been succesfully added as organiser.")
    else
      render :action => "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,:last_name,:country, :password, :password_confirmation, :avatar
    )
  end
end
