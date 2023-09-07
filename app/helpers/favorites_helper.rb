module FavoritesHelper

  def fav_or_unfave_button(movie, favorite)
     if favorite
        button_to "Un-Fave", movie_favorite_path(@movie, @favorite),
          method: :delete
      else
        button_to "Fave", movie_favorites_path(@movie)
     end
  end
end
