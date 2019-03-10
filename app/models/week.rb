class Week < ActiveRecord::Base
  belongs_to :edition
  has_many :roadmap_entries, dependent: :destroy

  scope :order_by_number, -> { order(number: :asc) }


  def self.current
    Edition.current.weeks.find_by(start: Date.current.beginning_of_week)
  end

  def previous_week
    Edition.current.weeks.find_by(number: (self.number - 1))
  end
end
