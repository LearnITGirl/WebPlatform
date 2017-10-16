class AssignedBadge < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge

  scope :not_displayed, -> { where(displayed: false) }
end
