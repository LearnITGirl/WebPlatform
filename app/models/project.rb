class Project < ActiveRecord::Base
  belongs_to :mentor, class_name: 'User', foreign_key: "mentor_id"
  belongs_to :mentee, class_name: 'User', foreign_key: "mentee_id"
  has_many :tasks, dependent: :destroy

  validates :mentee_id, presence: true, on: :update
  validates :title, :language, :description, :github_link, presence: true, on: :update

  validates :github_link, format: { with: GITHUB_REGEXP }
end
