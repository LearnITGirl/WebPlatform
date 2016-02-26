module UsersHelper

  def not_missing_yet?(partner)
    !partner.is_missing && partner.last_activity_at && partner.last_activity_at > 3.days.ago
  end

  def first_month?
    edition_started? && (DateTime.now > current_edition.weeks.find_by(number: 4).end.end_of_day)
  end
end
