class Badge < ActiveRecord::Base
  has_many :assigned_badges
  has_many :users, through: :assigned_badges

  #TODO: correct number for next edition

  enum name: {
    midterm_survey: 1, final_survey: 2,
    organized: 3, ambitious: 4, energetic: 5,
    timekeeper: 6, novice: 7,
    coder: 9, visionary: 10
  }

  # assign 'badge' to 'user'
  def self.assign(user, badge, week_id, upgrade = false, upgraded_from = nil)
    user.badges << badge unless user.badges.include?(badge.first)
    assigned_badge = user.assigned_badges.where(badge_id: badge.first.id).last
    assigned_badge.update(week_id: week_id, upgrade: upgrade, upgraded_from: upgraded_from)
  end

  def self.disable(user, badge, week_id)
    badge_to_disable = user.assigned_badges.find_by(badge_id: badge.first.id, week_id: week_id)
    return unless badge_to_disable.present?
    badge_to_disable.update(active: false)
  end

end
