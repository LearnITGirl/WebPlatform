class MentorToMenteeMatchersController < ApplicationController
  def index
    locals={
      matched_paires: ApplicationMatch.all.order("created_at DESC")
    }

    render 'index', locals: locals
  end

  def match
    last_number = ApplicationMatch.all.size
    new_number =  MentorToMenteeMatcher.new.run

    respond_to do |format|
      format.json { render json: {number: (last_number-new_number).abs}, status: :ok }
    end
  end

  def accept_pair
    application_match = ApplicationMatch.where(id: params[:id]).first
    application_match.update_attributes(confirmed: true)
    #
    #To Do: Create user account for both
    #
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

  def reject_mentor
    application_match = ApplicationMatch.where(id: params[:id]).first
    application_match.mentor_application.update_attribute(:state, :rejected)
    application_match.delete

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

  def reject_mentee
    application_match = ApplicationMatch.where(id: params[:id]).first
    application_match.mentee_application.update_attribute(:state, :rejected)
    application_match.delete

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
end
