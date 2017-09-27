class UserResignation
  attr_reader :user, :partner, :project, :reason

  def initialize(user:)
    @user = user
    @partner = user.partner
    @project = user.project
  end

  def proceed(reason:)
    @reason = reason

    ActiveRecord::Base.transaction do
      application_match.delete
      project.delete

      handle_user_state
      handle_partner_state

    end
  end

  private

  def application_match
    ids = [user.application.id, partner.application.id]
    ApplicationMatch.where(mentor_application_id: ids, mentee_application_id: ids).first
  end

  def handle_user_state
    application = user.application
    application.state = :user_resigned
    application.resignation_reason = reason
    application.save

    user.delete
  end

  def handle_partner_state
    application = partner.application
    application.state = :waiting_for_rematch
    application.rematch_reason = reason
    application.save
  end
end
