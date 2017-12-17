namespace :award_badges do
  desc "award timekeeper, energetic and ambitious badges"
  task timeline_badges: :environment do
    if DateTime.current.wday == 1
      current_week = Week.current.previous_week
      prev_week = current_week.previous_week
      Project.current_edition.each do |project|
        mentee = project.mentee
        if project.tasks_completed_for_week?(current_week.number)
          badges_for_last_week = mentee.assigned_badges.where(week_id: prev_week.id) if prev_week.present?
          if badges_for_last_week.blank? || badges_for_last_week.include_badge?(Badge.ambitious)
            Badge.assign(mentee, Badge.timekeeper, current_week.id)
          elsif badges_for_last_week.include_badge?(Badge.timekeeper)
            # upgrade badge from timekeeper to energetic
            Badge.disable(mentee, Badge.timekeeper, prev_week.id)
            Badge.assign(mentee, Badge.energetic, current_week.id, true, Badge.timekeeper.first.id)
          elsif badges_for_last_week.include_badge?(Badge.energetic)
            # upgrade badge from energetic to ambitious
            Badge.disable(mentee, Badge.energetic, prev_week.id)
            Badge.assign(mentee, Badge.ambitious, current_week.id, true, Badge.energetic.first.id)
          end
        end
      end
    end
  end

end

