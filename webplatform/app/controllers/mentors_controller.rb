class MentorsController < ApplicationController

  def new
    @mentor = Mentor.create(build_step: :personal_information)
    redirect_to mentor_build_path(:personal_information, mentor_id: @mentor.id)
  end
end
