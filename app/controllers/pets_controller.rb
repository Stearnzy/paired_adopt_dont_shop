class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
  end

  def show
    @pet = Pet.find(params[:id])
  end
end