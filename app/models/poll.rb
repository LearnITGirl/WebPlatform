class Poll < ActiveRecord::Base
  validates :answer, presence: true

end
