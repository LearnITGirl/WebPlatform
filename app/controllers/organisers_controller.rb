class OrganisersController < ApplicationController
  before_action :require_organiser

  def dashboard
    @mentees = MenteeApplication.where.not(email: current_user.email)
                                .active.not_evaluated.know_english
                                .have_time_to_learn.not_male
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
    redirect_to dashboard_organisers_path, notice: "Deleted successfully!"
  end

  def problematic_projects
    @projects = User.where("is_missing = (?) OR last_activity_at is null or last_activity_at <= (?)", true, 15.days.ago).map{|user| user.project}.uniq.compact
  end

  private

  def display_organisers
    @organisers = User.where(role: 1, organiser_token:nil)
  end

  def organisers_left
    @pending_organisers = User.where(role: 1).where.not(organiser_token: nil)
  end

  def organizer_params
    params.require(:user).permit(:first_name, :last_name, :country, :password, :password_confirmation, :avatar)
  end

  def current_dashboard_view
    if (Date.today > current_edition.end_date)
      @projects = Project.all
      'final_project_evaluation'
    elsif @mentees.blank? and @mentors.blank? and DateTime.current >= current_edition.start_date.beginning_of_day
      @projects = Project.all
      'ongoing_projects'
    else
      'evaluate_projects'
    end
  end

end
