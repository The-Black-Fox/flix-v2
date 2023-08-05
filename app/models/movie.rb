class Movie < ApplicationRecord
  def flop?
    total_gross < 255_000_000 || total_gross.blank?
  end
end
