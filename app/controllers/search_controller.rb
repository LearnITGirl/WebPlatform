class SearchController < ApplicationController
  def participants
    if params[:query].present?
      mentors_sql = User.joins(:mentor_project)
      .select(:id)
      .where('lower(users.first_name) ~ :q OR lower(users.last_name) ~ :q OR lower(users.email) ~ :q OR lower(projects.title) ~ :q', q: params[:query].downcase)
      .to_sql
      mentees_sql = User.joins(:mentee_project)
      .select(:id)
      .where('lower(users.first_name) ~ :q OR lower(users.last_name) ~ :q OR lower(users.email) ~ :q OR lower(projects.title) ~ :q', q: params[:query].downcase)
      .to_sql

      users = User.where("users.id IN (#{mentors_sql}) OR users.id IN (#{mentees_sql})")
                  .eager_load(:mentor_project, :mentee_project)
                  .select('projects.title, users.*')

      render json: {suggestions: users_hash(users)}
    else
      render json: {suggestions: []}
    end
  end

  private

  def users_hash(users)
    users.map do|x|
      {
        value: "#{x.first_name} #{x.last_name} - #{x.email} - #{x.project.title}",
        data: x.role == "mentee" ? mentor_profile_url(x) : mentee_profile_url(x)
      }
    end
  end
end
