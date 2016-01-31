class MentorToMenteeMatchersController < ApplicationController
  def index
    locals={
      matched_paires: ApplicationMatch.all.order("created_at DESC")
    }

    render 'index', locals: locals
  end

  def match
    number = 0

    ActiveRecord::Base.transaction do
      number = MentorToMenteeMatcher.new.run

      ApplicationMatch.all.each do |application|
        ProjectSetup.new(mentor_application: application.mentor_application,
                         mentee_application: application.mentee_application)
                    .create
      end
    end

    respond_to do |format|
      format.json { render json: {number: number.abs}, status: :ok }
    end
  end
end
