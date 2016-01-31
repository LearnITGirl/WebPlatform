class Edition < ActiveRecord::Base
  has_many :users
  has_many :projects
end
