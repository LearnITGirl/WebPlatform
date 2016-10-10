class FinalSurvey < ActiveRecord::Base
  belongs_to :edition
  belongs_to :project
  belongs_to :mentor, class_name: 'User', foreign_key: "mentor_id"
  belongs_to :mentee, class_name: 'User', foreign_key: "mentee_id"
end
