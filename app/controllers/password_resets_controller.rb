class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def create
    @user = User.find_by(email: params[:email])

    if @user
      @user.deliver_reset_password_instructions!
      redirect_to root_path, notice: 'Instructions have been sent to your email'
    else
      flash.now[:alert] = "User doesn't exist"
      render "new"
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to root_path, notice: 'Password was successfully updated'
    else
      render "edit"
    end
  end
end
