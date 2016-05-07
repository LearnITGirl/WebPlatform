class Edition < ActiveRecord::Base
  has_many :weeks
  has_many :final_surveys
end
