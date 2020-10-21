class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    shelter = Shelter.new({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
      })

    shelter.save

    redirect_to '/shelters'
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = @shelter.reviews
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
      })

      shelter.save

      redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    @shelter = Shelter.find(params[:id])
    @reviews = @shelter.reviews
    if @shelter.any_pending_applications?
      flash.now[:notice] = "Cannot delete shelter with pending applications!"
      render :show
    elsif @shelter.pets.count == 0 || @shelter.all_pets_adoptable?
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    end
  end
end