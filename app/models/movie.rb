class Movie < ApplicationRecord

  def self.released
    Movie.where("released_on <= ?", Time.now).order(released_on: :desc )
  end

  def flop?
    total_gross.nil? ||  total_gross.blank? || total_gross < 255_000_000
  end
end
