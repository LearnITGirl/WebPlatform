class User < ActiveRecord::Base
  authenticates_with_sorcery!

  mount_uploader :avatar, AvatarUploader

  enum role: {organizer: 1, mentee: 2, mentor: 3}

  validates :password, length: { minimum: 6 }, if: -> { password || password_confirmation }
  validates :password, confirmation: true, if: -> { password || password_confirmation }
  validates :password_confirmation, presence: true, if: -> { password || password_confirmation }
  validates :email,  uniqueness: { case_sensitive: false } , presence: true,  format: { with: REGEXP_EMAIL }
  validates :first_name, :last_name, :country, :avatar, presence: true, on: :update

  before_create :create_organiser_token

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def create_organiser_token
    self.organiser_token = SecureRandom.hex(8) if role == 'organizer'
  end
end
