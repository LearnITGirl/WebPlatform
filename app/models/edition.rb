class Edition < ActiveRecord::Base
  has_many :weeks
  has_many :final_surveys
  has_many :projects
  has_many :mentor_applications
  has_many :mentee_applications
  has_many :roadmap_entries, dependent: :destroy

  def self.current
    last
  end
end
