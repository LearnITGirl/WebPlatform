class User < ActiveRecord::Base
  authenticates_with_sorcery!
  before_create :create_organiser_token

  validates :password, length: { minimum: 6 }, if: -> { password || password_confirmation }
  validates :password, confirmation: true, if: -> { password || password_confirmation }
  validates :password_confirmation, presence: true, if: -> { password || password_confirmation }

  validates :email,  uniqueness: { case_sensitive: false } , presence: true,  format: { with: REGEXP_EMAIL }, on: :create

  enum role: {organizer: 1, mentee: 2, mentor: 3}

  private
    def create_organiser_token
      if self.role == 'organizer'
         self.organiser_token = SecureRandom.hex(8)
      end
    end
end
