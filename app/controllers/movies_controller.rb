class MoviesController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :all_movie_genres, only: [:create, :edit, :new]
  before_action :find_movie, except: [:index, :new]

  def index
    @movies = case params[:filter]
    when "released"
      Movie.released
    when "upcoming"
      Movie.upcoming
    when "recent"
      Movie.recent
    when "flops"
      Movie.flops
    when "hits"
      Movie.hits
    else
      Movie.released
    end
  end

  def show

    @genres = @movie.genres.order(:name)
    @review = @movie.reviews.new
    @fans = @movie.fans
    if current_user
      @favorite = current_user.favorites.find_by(movie:@movie.id)
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie succesfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice:"Movie succesfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url, notice: "Movie succesfully deleted!", status: :see_other
  end

private

  def find_movie
    @movie = Movie.find_by(slug: params[:id])
  end

  def movie_params
    params.require(:movie)
      .permit(:title, :description, :rating, :released_on, :total_gross, :director,
              :duration, :main_image, genre_ids: [])
  end

  def all_movie_genres
    @all_genres = Genre.all.order(:name)
  end
end
