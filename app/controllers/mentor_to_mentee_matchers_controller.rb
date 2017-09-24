class MentorToMenteeMatchersController < ApplicationController
  def index
    locals={
      all_applications_evaluated: all_applications_evaluated?,
      matched_paires: ApplicationMatch.all.order("created_at DESC"),
      mentors_waiting_for_re_match: MentorApplication.where(state: 5),
      mentees_waiting_for_re_match: MenteeApplication.where(state: 5),
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

  private

  def all_applications_evaluated?
    (MenteeApplication.left_for_evaluation + MentorApplication.left_for_evaluation) == 0
  end
end
