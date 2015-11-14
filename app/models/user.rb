class User < ActiveRecord::Base
  authenticates_with_sorcery!
  before_create :create_organiser_token

  validates :password, length: { minimum: 6 }, if: -> { password || password_confirmation }
  validates :password, confirmation: true, if: -> { password || password_confirmation }
  validates :password_confirmation, presence: true, if: -> { password || password_confirmation }

  validates :email, uniqueness: true

  enum role: {organizer: 1, mentee: 2, mentor: 3}

  private
    def create_organiser_token
      self.organiser_token = SecureRandom.hex(8)
    end


end
