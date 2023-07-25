class MoviesController < ApplicationController
  def index
    @movies = [ "iron Man", "Superman", "Spider-Man", "Boon Boon goes to New York"]
  end
end
