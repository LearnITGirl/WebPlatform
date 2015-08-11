class Mentor < ActiveRecord::Base

  validates :first_name, :last_name, :email, :gender, :country, :program_country,
            :time_zone, :motivation, :english_level, :mentee_level,
            :mentor_experience,  presence: true, on: :update
  validates :email, format: { with: REGEXP_EMAIL }, on: :update
end
