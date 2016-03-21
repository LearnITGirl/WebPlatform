class MenteeMidtermEvaluation < ActiveRecord::Base
  belongs_to :mentee, class_name: 'User', foreign_key: "mentee_id"
end
