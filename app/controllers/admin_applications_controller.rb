class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_app = PetApplication.where(application_id: @application.id)
  end

  def update
    application = Application.find(params[:id])
    pet_app = PetApplication.find_by(pet_id: [params[:key]])
    pet_app.update({
      approval: "Approved"
      })
    redirect_to "/admin/applications/#{application.id}"
  end
end