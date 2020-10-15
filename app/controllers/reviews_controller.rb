class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
    # @user = User.find(params[:user_id])
  end

  def create
    @user = User.find_by(params[:name])
    @shelter = Shelter.find(params[:shelter_id])
    review = Review.new({
      user_name: params[:user_name],
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: params[:picture],
      shelter_id: @shelter.id,
      # user_id: @user.id
      })
    # if review.user_name != @user.name
    #   flash[:notice] = "User name does not exist."
    #   render :new
    # else
    #   review.save
    #   redirect_to "/shelters/#{review.shelter.id}"
    # end
  end

  def edit
    @shelter = Shelter.find(params[:shelter_id])
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: params[:picture],
      shelter_id: params[:shelter_id],
      user_id: params[:user_id]
      })

    shelter_id = review.shelter_id

    redirect_to "/shelters/#{shelter_id}"
  end

  def destroy
    shelter = Shelter.find(params[:shelter_id])
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{shelter.id}"
  end
end