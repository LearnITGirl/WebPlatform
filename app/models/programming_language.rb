class ProgrammingLanguage < ActiveRecord::Base
  has_and_belongs_to_many :mentor_applications
  has_many :mentee_application

  has_many :projects
end
