class ReviewController < ApplicationController
  def new
    @shelter = Shelter.params([:shelter_id])
  end

  def create
    @review = Review.create!(review_params)
    redirect_to "/shelters/:shelter_id"
  end

  def review_params
    params.require(:title, :rating, :content, :user_name).permit(:picture)
  end

end