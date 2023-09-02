class ReviewsController < ApplicationController
  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new

  end

  def create

    @review = @movie.reviews.new(review_params)

    if @review.save
      redirect_to movie_reviews_path(@movie),
         notice:"Thank you for your review."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if  @review.update(review_params)
      redirect_to movie_reviews_path(@movie),
         notice:"You have succesfully updated your review."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def destroy
    @review = Review.find(params[:id])
    @review.destroy
      redirect_to movie_reviews_path(params[:movie_id]), notice: "Review succesfully deleted!", status: :see_other
  end

  private

  def set_movie
   @movie = Movie.find(params[:movie_id])

  end

  def review_params
    params.require(:review)
      .permit(:name, :stars, :comment)
  end

end
