class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    # @pet_application = PetApplication.find_by(params[:id])
    @call_pets = call_pets_by_app
    # require "pry"; binding.pry
    
  end

  def update

  end

private
  def call_pets_by_app
    pets = @application.pets.map {|pet| pet.id}
    pet_ids = pets.each {|pet| PetApplication.find_by(params[:pet_id])}
    pet_application_objects = pet_ids.map do |pet|
      PetApplication.find_by(params[:pet_id])
    end
    pet_application_objects
  end

end