class ApplicationMatch < ActiveRecord::Base
  belongs_to :mentee_application
  belongs_to :mentor_application
end
