class Evaluation < ActiveRecord::Base
  belongs_to :mentor_application
  belongs_to :mentee_application
  belongs_to :user

  validates_uniqueness_of :mentee_application_id, scope: :user_id, :allow_nil => true
  validates_uniqueness_of :mentor_application_id, scope: :user_id, :allow_nil => true

  def application
    mentor_application || mentee_application
  end
end
