module UsersHelper

  def not_missing_yet?(partner)
    !partner.is_missing && partner.last_activity_at && partner.last_activity_at > 3.days.ago
  end

  def first_month?
    edition_started? && (DateTime.current <= current_edition.weeks.find_by(number: 4).end.end_of_day)
  end

  def new_badge_description(badge, upgrade_from_badge)
    return unless badge
    description = ""
    if upgrade_from_badge.present?
      description += "Your badge has been upgraded from #{upgrade_from_badge.name.titleize}. "
    end
    description += "Your new badge is called #{badge.name.titleize}. #{badge.description}"
  end

  def first_week?
    week = first_week
    DateTime.current.between?(week.start, week.end)
  end

  def first_week
    current_edition.weeks.find_by(number: 1)
  end
end
