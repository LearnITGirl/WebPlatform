class Evaluation < ActiveRecord::Base
  belongs_to :mentor_application
  belongs_to :mentee_application
  belongs_to :user

  def application
    mentor_application || mentee_application
  end
end
