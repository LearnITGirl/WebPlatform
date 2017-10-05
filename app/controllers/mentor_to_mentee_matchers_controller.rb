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
      create_projects
    end

    respond_to do |format|
      format.json { render json: {number: number.abs}, status: :ok }
    end
  end

  def rematch
    pairs_number = ApplicationMatch.all.count

    ActiveRecord::Base.transaction do
      MentorToMenteeMatcher.new.rematch
      create_projects

      MenteeApplication.waiting_for_rematch.each do |application|
        if application.user.project.present?
          application.update_attributes(state: :rematched)
          update_partner_application_state(application)
        end
      end

      MentorApplication.waiting_for_rematch.each do |application|
        if application.user.project.present?
          application.update_attributes(state: :rematched)
          update_partner_application_state(application)
        end
      end
    end

    pairs_number = ApplicationMatch.all.count - pairs_number

    respond_to do |format|
      format.json { render json: { number: pairs_number }, status: :ok }
    end
  end

  private

  def all_applications_evaluated?
    (MenteeApplication.left_for_evaluation + MentorApplication.left_for_evaluation) == 0
  end

  def create_projects
    ApplicationMatch.all.each do |application|
      ProjectSetup.new(mentor_application: application.mentor_application,
                       mentee_application: application.mentee_application)
        .create
    end
  end

  def update_partner_application_state(application)
   partner_application = application.user.partner.application

   if application.rematched? && partner_application.waiting_for_rematch?
      partner_application.update_attributes(state: :rematched)
   elsif application.rematched? && partner_application.evaluated?
      partner_application.update_attributes(state: :rematched_from_waiting_list)
   end
  end
end
