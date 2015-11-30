class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  def new
   @user = User.new
  end

  def create
    if @user = login(params[:session][:email], params[:session][:password])
      redirect_to root_path, notice: "Login Succesful!"
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
   end

  def destroy
    logout
    redirect_to root_path, notice: "Logged out!"
  end
end
