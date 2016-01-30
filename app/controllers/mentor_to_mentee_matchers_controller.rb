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

    project_setup = ProjectSetup.new(mentor_application: application_match.mentor_application,
                                     mentee_application: application_match.mentee_application)

    respond_to do |format|
      if project_setup.create
        application_match.update_attributes(confirmed: true)
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: {}, status: :unprocessable_entity }
      end
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
