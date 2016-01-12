class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, class_name: 'User', foreign_key: "creator_id"

  enum status: {not_done: 1, finished_by_mentee: 2, finished_by_mentor: 3}
  
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, on: :create, length: { maximum: 300 }

end
