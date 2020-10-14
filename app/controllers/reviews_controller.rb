class ReviewsController < ApplicationController
  def new
    # @shelter = Shelter.find(params[:shelter_id])
    # @user = User.find(params[:user_id])
  end

  def create
    # @user = User.find(params[:user_id])
    @shelter = Shelter.find(params[:id])
    review = Review.create!({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: params[:picture],
      shelter_id: params[:shelter_id],
      user_id: params[:user_id]
      })
    redirect_to "/shelters/#{shelter.id}"
  end
end