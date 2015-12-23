class Evaluation < ActiveRecord::Base
  belongs_to :mentor_application
  belongs_to :mentee_application
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :mentor_application_id
  validates_uniqueness_of :user_id, scope: :mentee_application_id

  def application
    mentor_application || mentee_application
  end
end
