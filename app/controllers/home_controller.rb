class HomeController < ApplicationController

  def index
    @current_edition = current_edition
    @registration_open = registration_open?
    current_home_page if current_user
  end

  def first_edition_projects
  end

  def second_edition_projects
  end

  def third_edition_projects
  end
  
  def sponsors
  end

  def mentor_dos_and_donts
  end

  def mentee_dos_and_donts
  end

  def faq
  end

  def timeline
  end

  def roadmap
  end

  def about_us
  end

  def privacy_policy
  end

  private

  def current_home_page
    redirect_to case current_user.role
    when "mentee" then dashboard_mentee_profiles_path
    when "mentor" then dashboard_mentor_profiles_path
    when "organizer" then organisers_path
    end
  end
end
