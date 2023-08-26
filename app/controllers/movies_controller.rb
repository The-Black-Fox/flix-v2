class MoviesController < ApplicationController

  def index
    @movies = Movie.released
  end

  def show
    @movie = find_movie
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = find_movie
    redirect_to(@movie)
  end

  def edit
    @movie = find_movie
  end

  def update
    @movie = find_movie

    @movie.update(movie_params)
    redirect_to (@movie)
  end

  def destroy
    find_movie.destroy
    redirect_to  movies_url,  status: :see_other
  end

  private

  def find_movie
    Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie)
      .permit(:title, :description, :rating, :released_on, :total_gross)
  end
end
