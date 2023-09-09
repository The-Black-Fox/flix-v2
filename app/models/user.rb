class User < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/,
    message: "please enter a valid email address" },
    uniqueness: { case_sensitive: false }
  validates :username,
    format: { with:  /\A[A-Z0-9]+\z/i ,
              message: "only allow letters, numbers without spaces." },
    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 10, allow_blank: true }
  has_secure_password


  scope :by_name, -> {order(name: :desc)}
  scope :admin, ->{where(admin: true)}
  scope :not_admin, ->{where(admin: false)}

  before_save :set_lower_case_username
  before_save :set_lower_case_email

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end


  def to_param
    username
  end

  private

  def set_lower_case_username
    self.username = username.downcase
  end

  def set_lower_case_email
    self.email = email.downcase
  end


end
