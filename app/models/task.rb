class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, class_name: 'User', foreign_key: "creator_id"

  enum status: {not_done: 1, finished: 2, accepted: 3, trash: 4, deleted: 5}

  validates :title, presence: true

  def self.finished(user)
    where("(status = 3) or (creator_id = :user_id and finished_by = :user_id and status = 2) or (creator_id != :user_id and finished_by != :user_id and status = 2)", {user_id: user.id})
  end

  def self.unfinished(user)
    where("(status = 1) or (creator_id = :user_id and finished_by != :user_id and status = 2) or (creator_id != :user_id and finished_by = :user_id and status = 2) or (status = 4)", {user_id: user.id})
  end

  def self.not_deleted
    where(deleted_at: nil)
  end

  def self.new_tasks(date)
    where(status:1, created_at: (date.beginning_of_week..date.end_of_week))
  end

  def self.deleted_tasks(date)
    where(status: 5, deleted_at: (date.beginning_of_week..date.end_of_week))
  end

  def self.completed_tasks(date)
    where(updated_at: (date.beginning_of_week..date.end_of_week)).
      where("(status = 3) or (creator_id = :user_id and finished_by = :user_id and status = 2) or (creator_id != :user_id and finished_by != :user_id and status = 2)", {user_id: id})
  end

  def self.unconfirmed_completed_tasks(date)
    where("(status = 2 and creator_id=(?) and creator_id != finished_by and updated_at BETWEEN (?) AND (?))", id, date.beginning_of_week, date.end_of_week)
  end

  def self.unconfirmed_deleted_tasks(date)
    where("(status = 4 and creator_id=(?) and creator_id != finished_by and updated_at BETWEEN (?) AND (?))", id, date.beginning_of_week, date.end_of_week)
  end


end
