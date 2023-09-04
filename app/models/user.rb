class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/,
    message: "please enter a valid email address" },
    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 10, allow_blank: true }
end
