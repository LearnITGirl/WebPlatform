class FinalSurvey < ActiveRecord::Base
  belongs_to :edition
  belongs_to :project
  belongs_to :mentor, class_name: 'User', foreign_key: "mentor_id"
  belongs_to :mentee, class_name: 'User', foreign_key: "mentee_id"

  mount_uploader :mentee_demo_file, ProjectDemoUploader
  validates :mentee_demo_file, file_size: { less_than: 25.megabytes }

  def mentee_demo
    mentee_demo_url || mentee_demo_file.try(:url)
  end
end
