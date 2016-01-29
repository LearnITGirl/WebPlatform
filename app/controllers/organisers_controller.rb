class OrganisersController < ApplicationController
  before_action :require_organiser

  def dashboard
    @mentees = MenteeApplication.where.not(email: current_user.email)
                                .active.not_evaluated.know_english.have_time_to_learn
    @mentors = MentorApplication.where.not(email: current_user.email)
                                .active.not_evaluated.know_english.have_time_to_learn
    render current_dashboard_view
  end

  def index
    display_organisers
    organisers_left
  end

  def create
    @user = User.new(email: params[:email], role:1)

    if @user.save
      OrganisersMailer.register(@user).deliver_now
      redirect_to organisers_path, notice: 'Instructions have been sent to the email'
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      display_organisers
      organisers_left
      render "index"
    end
  end


  def edit
    @organizer = current_user
  end

  def update
    @organizer = current_user
    if @organizer.update_attributes(organizer_params)
      redirect_to(organisers_path, notice: "Details were successfully updated.")
    else
      render "edit"
    end
  end

  def destroy
    @organizer = User.find_by(role:1, id: params[:id])
    @organizer.delete
    redirect_to :back, notice: "Deleted successfully!"
  end
  
  def problematic_projects
    @projects = User.where(is_missing: true).map{|user| user.project}.uniq.compact
  end

  private

  def display_organisers
    @organisers = User.where(role: 1, organiser_token:nil)
  end

  def organisers_left
    @pending_organisers = User.where(role: 1).where.not(organiser_token: nil)
  end

  def organizer_params
    params.require(:user).permit(:first_name,:last_name,:country, :password, :password_confirmation, :avatar)
  end

  def current_dashboard_view
    if (@mentees.length > 0 or @mentors.length > 0)
       'evaluate_projects'
    elsif (@mentees.length <= 0 and @mentors.length <= 0)
       @projects = Project.all
       'ongoing_projects'
    # else if (current_date > edition date)
       #'project_evaluate'
    end
  end
end
