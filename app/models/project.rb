class Project < ActiveRecord::Base

  belongs_to :mentor, class_name: 'User', foreign_key: "mentor_id"
  belongs_to :mentee, class_name: 'User', foreign_key: "mentee_id"

  validates :mentee_id, presence: true, on: :update

end
