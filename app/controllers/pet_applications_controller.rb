class PetApplicationsController < ApplicationController
  def create
    @application = Application.find(params[:id])
    @pet_app = PetApplication.create!({
      pet_id: params[:pet_id],
      application_id: params[:id],
      approval: "Pending"
      })
    redirect_to "/applications/#{@application.id}"
  end

  def index
    @pet = Pet.find(params[:id])
  end
  
end