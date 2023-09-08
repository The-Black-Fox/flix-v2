module MoviesHelper
  def total_gross(movie)
    if movie.flop?
      "Flop!"
    else
      number_to_currency(movie.total_gross, precision: 0,)
    end
  end

  def year_of(movie)
    movie.released_on.year
  end


  def nav_link_to(name, route_helper)
    if current_page?(route_helper)
      tag.li link_to(name, route_helper, class: "active")
    else
      tag.li link_to(name, route_helper)
    end
  end
end
