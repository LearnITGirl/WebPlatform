class Newsletter < ActiveRecord::Base
  validates :email, uniqueness: { case_sensitive: false },
                    presence: true,  format: { with: REGEXP_EMAIL }
end
