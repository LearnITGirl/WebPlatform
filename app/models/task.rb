class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, class_name: 'User', foreign_key: "creator_id"

  enum status: {not_done: 1, finished: 2, accepted: 3}

  validates :title, presence: true

  def self.finished(user)
    where("(creator_id != (?) and status = 3) or (creator_id= (?) and status in (?))", user.id, user.id, [2,3])
  end

  def self.unfinished(user)
    where("(creator_id != (?) and status in (?)) or (creator_id= (?) and status = 1)", user.id, [1,2], user.id)
  end
end
