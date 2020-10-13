class ReviewController < ApplicationController

  def create 
    @review = Review.create(review_params)
  end

  def review_params
    params.require(:title, :rating, :content, :user_name).permit(:picture)
  end
  
end