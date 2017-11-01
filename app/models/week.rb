class Week < ActiveRecord::Base
  belongs_to :edition

  scope :order_by_number, -> { order(number: :asc) }

  def self.get_previous_week_by_date(date)
    week_for_date = Edition.current.weeks.find_by(start: date.beginning_of_week)
    Edition.current.weeks.find_by(number: (week_for_date.number - 1))
  end

  def get_previous_week
    Edition.current.weeks.find_by(number: (self.number - 1))
  end
end
