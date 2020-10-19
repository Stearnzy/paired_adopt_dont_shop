class PetApplicationsController < ApplicationController
  def create
    @application = Application.find(params[:id])
    @pet_app = PetApplication.create!({
      pet_id: params[:pet_id],
      application_id: params[:id]
      })
    redirect_to "/applications/#{@application.id}"
  end
end