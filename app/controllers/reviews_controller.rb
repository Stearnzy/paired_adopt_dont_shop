class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    @review = Review.new({
      user_name: params[:user_name],
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: params[:picture],
      shelter_id: @shelter.id,
      user_id: params[:user_id]
      })

    @user = User.where(name: @review.user_name)
    creation_validation
  end

  def creation_validation
    if @user == []
      flash[:notice] = "User name does not exist. Please enter a valid user's name."
      render :new
    elsif @user != [] && @review.title == "" || @review.rating == nil || @review.content == ""
      flash[:notice] = "Review not submitted - title, rating and content required."
      render :new
    else
      @review.user_id = @user[0].id
      @review.save
      redirect_to "/shelters/#{@review.shelter.id}"
    end
  end

  def edit
    @shelter = Shelter.find(params[:shelter_id])
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    @user = User.find_by(params[id: @review.user_id])
    @review.update({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: params[:picture],
      shelter_id: params[:shelter_id],
      user_id: @user.id
      })

    shelter_id = @review.shelter_id

    redirect_to "/shelters/#{shelter_id}"
  end

  def destroy
    shelter = Shelter.find(params[:shelter_id])
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{shelter.id}"
  end
end