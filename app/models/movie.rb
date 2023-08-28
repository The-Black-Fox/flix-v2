class Movie < ApplicationRecord

  RATINGS = %w(G PG PG-13 R NC-17)

  def self.released
    Movie.where("released_on <= ?", Time.now).order(released_on: :desc )
  end

  def flop?
    total_gross.nil? ||  total_gross.blank? || total_gross < 255_000_000
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
