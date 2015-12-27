class MenteeProfilesController < ApplicationController
  before_action :require_mentee, except: [ :show ]
  before_action :require_login, only: [:show]

  def show
    @user = User.find(params[:id])
    @mentor = User.find(@user.matched_id)
    @project = Project.find_by(mentee_id: params[:id])
  end

  def dashboard
    @mentor = User.find(current_user.matched_id)
    @project = Project.find_by(mentee_id: current_user.id)

  end

  def edit
    @menteeid = params[:id]
    @user = User.find(params[:id])
    @project = Project.find_by(mentee_id: params[:id])

    if @user.blank? or @user.role != "mentee"
      not_authenticated
      return
    end
  end

  def update
    @menteeid = params[:id]
    @user = User.find(params[:id])

    if @user.blank? or @user.role != "mentee"
      not_authenticated
      return
    end
    if @user.update_attributes(user_params) 
      redirect_to(mentee_profile_path, :notice => "Details have been succesfuly updated.")
    else
      render :action => "edit"
    end
  end

  def missing_mentor
    @user = current_user
    @mentor = User.find(current_user.matched_id)
    if @mentor.update_attribute(:is_missing, true)
      MissingPersonsMailer.missing_mentor(@user).deliver_now
      redirect_to dashboard_mentee_profiles_path, notice: 'Organsiers Have been notified about the missing mentor'
    else
      redirect_to dashboard_mentee_profiles_path, notice: 'Couldnt send mail'
    end
  end
  
  private
  def user_params
    params.permit( :_method, :authenticity_token, :commit, :user => [:id,:first_name, :last_name, :country, :timezone, :project_attributes => [:id, :title,:language,:description,:github_link]])
  end
  
  def project_params
     params.permit(:user => [:project_attributes => [:title,:language,:description,:github_link]])
  end


end
