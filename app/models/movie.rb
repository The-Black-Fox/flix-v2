class Movie < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations
  has_many :critics, through: :reviews, source: :user
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  has_one_attached :main_image

  RATINGS = %w(G PG PG-13 R NC-17)

  scope :released, -> {where("released_on <= ?", Time.now).order(released_on: :desc)}
  scope :upcoming, -> {where("released_on > ?", Time.now).order(released_on: :desc)}
  scope :recent, -> (max=5) {released.limit(max)}
  scope :hits, -> {released.where("total_gross >= 300000000").order(total_gross: :desc)}
  scope :flops, -> {where("total_gross <= 255000000").order(total_gross: :desc)}

  validates :released_on, :duration, presence: true
  validates :title, presence: true, uniqueness: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

  validates :rating, inclusion: {
    in: RATINGS,
    message: "must be a valid rating"
  }

  validate :acceptable_image

  before_save :set_slug

  def flop?
    unless reviews.count(:id) > 50 && average_stars >= 4
      total_gross.nil? ||  total_gross.blank? || total_gross < 255_000_000
    end
  end

  def average_stars
    reviews.average(:stars)|| 0.0
  end

  def average_stars_as_percent
    (average_stars / 5) * 100
  end


  def to_param
    slug
  end

  private

  def set_slug
    self.slug = title.parameterize
  end

  def acceptable_image
    return unless main_image.attached?

    unless main_image.blob.byte_size < 1.megabyte
      errors.add(:main_image, "Image is too big")
    end

    acceptable_image_types = ["image/jpeg", "image/png"]
    unless acceptable_image_types.include?(main_image.blob.content_type)
        errors.add(:main_image, "Upload a Jpeg or PNG file type")
    end
  end

end
