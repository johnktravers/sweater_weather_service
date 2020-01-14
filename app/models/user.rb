class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :api_key, presence: true, uniqueness: true, length: { is: 32 }

  has_secure_password
  validates_presence_of :password_confirmation
end
