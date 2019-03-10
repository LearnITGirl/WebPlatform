class RoadmapEntry < ActiveRecord::Base
  validates :content, :week,  presence: true

  belongs_to :edition
  belongs_to :project
  belongs_to :week
end
