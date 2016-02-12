class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, class_name: 'User', foreign_key: "creator_id"

  enum status: {not_done: 1, finished: 2, accepted: 3}

  validates :title, presence: true

  def self.finished(user)
    where("(status = 3) or (creator_id = :user_id and finished_by = :user_id and status = 2)", {user_id: user.id})
  end

  def self.unfinished(user)
    where("(status = 1) or (creator_id = :user_id and finished_by != :user_id and status = 2) or (creator_id != :user_id and finished_by = :user_id and status = 2)", {user_id: user.id})
  end
end
