class PetApplicationsController < ApplicationController
  def create
    # require "pry"; binding.pry
    @application = Application.find(params[:id])
    @pet_app = PetApplication.create!({
      pet_id: params[:pet_id],
      application_id: params[:id],
      approval: "Pending"
      })
    redirect_to "/applications/#{@application.id}"
  end
end