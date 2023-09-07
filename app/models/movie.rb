class Movie < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations
  has_many :critics, through: :reviews, source: :user
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user


  RATINGS = %w(G PG PG-13 R NC-17)

  def self.released
    Movie.where("released_on <= ?", Time.now).order(released_on: :desc )
  end

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

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }
  validates :rating, inclusion: {
    in: RATINGS,
    message: "must be a valid rating"
  }


end
