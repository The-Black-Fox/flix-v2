class Movie < ApplicationRecord
  def flop?
     total_gross < 255000000 || total_gross.blank?
  end
end
