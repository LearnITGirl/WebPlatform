class Week < ActiveRecord::Base
  belongs_to :edition

  scope :order_by_number, -> { order(number: :asc) }
end
