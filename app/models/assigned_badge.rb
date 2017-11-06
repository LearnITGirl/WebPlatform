class AssignedBadge < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge
  belongs_to :week

  scope :not_displayed, -> { where(displayed: false) }

  def self.include_badge?(badge)
    where(badge_id: badge.first.id).any?
  end
end
