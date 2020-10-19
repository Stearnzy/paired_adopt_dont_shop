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
      flash.now[:notice] = "User name does not exist. Please enter a valid user's name."
      render :new
    elsif @user != [] && @review.title == "" || @review.rating == nil || @review.content == ""
      flash.now[:notice] = "Review not submitted - title, rating and content required."
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
    @shelter = Shelter.find(params[:shelter_id])
    @review = Review.find(params[:review_id])
    @user = User.find_by(name: params[:user_name])
    @review.assign_attributes({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: params[:picture],
      shelter_id: params[:shelter_id],
      user_name: params[:user_name]
      })

    if @user.nil?
      flash[:notice] = "Please fill in a valid user name."
      render :edit
    elsif @review.valid?
      @review.save
      redirect_to "/shelters/#{@review.shelter_id}"
    else
      flash[:notice] = "Please fill in title, rating, and content before submitting."
      render :edit
    end
  end

  def destroy
    shelter = Shelter.find(params[:shelter_id])
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{shelter.id}"
  end
end