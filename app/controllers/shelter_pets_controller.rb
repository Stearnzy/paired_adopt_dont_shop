class ShelterPetsController < ApplicationController
  def index
    shelter = Shelter.find(params[:id])
    # require "pry"; binding.pry
    @pets = shelter.pets
  end
end