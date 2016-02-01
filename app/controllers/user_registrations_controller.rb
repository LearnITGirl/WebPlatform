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
    @project = Project.find_by(mentee_id: @user.id)

    if @user.blank?
      not_authenticated
      return
    end
    if @user.update_attributes(user_params)
      login(@user.email, user_params[:password])
      if @user.mentor?
        redirect_to(dashboard_mentor_profiles_path, :notice => "You've been succesfully added as Mentor.")
      elsif @user.mentee?
        render :action => "link_github"
      end
    else
      render :action => "edit"
    end
  end

  def link_github
    @token = params[:id]
    @user = User.find_by(registration_token: params[:id])
    @project = Project.find_by(mentee_id: @user.id)

    if @user.blank?
      not_authenticated
      return
    end
  end

  def update_github
    @token = params[:id]
    @user = User.find_by(registration_token: params[:id])
    @project = Project.find_by(mentee_id: @user.id)

    if @user.blank?
      not_authenticated
      return
    end

    if @project.update(github_link: params[:project][:github_link])
      @user.update(registration_token: nil)
      redirect_to(dashboard_mentee_profiles_path, :notice => "You've been successfully added as Scholar.")
    else
      render :action => "link_github"
    end
  end

  private

  def user_params
    params.require(:user).permit(:password).tap do |whitelisted|
      whitelisted[:password_confirmation] = params[:user][:password_confirmation]
      whitelisted[:registration_token] = nil if @user.mentor?
    end
  end

end
