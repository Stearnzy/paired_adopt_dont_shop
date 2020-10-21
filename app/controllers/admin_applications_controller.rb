class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @all_apps = PetApplication.where(application_id: @application.id)
  end

  def update
    @application = Application.find(params[:id])
    @all_apps = PetApplication.where(application_id: @application.id)
    @pet_app = PetApplication.find_by(pet_id: [params[:key]], application_id: @application.id)
    approve_or_reject_pet
    approve_or_reject_application
  end

private
  def approve_or_reject_pet
    if params[:value] == "approve"
      @pet_app.update({
        approval: "Approved"
        })
      redirect_to "/admin/applications/#{@application.id}"
    elsif params[:value] == "reject"
      @pet_app.update({
        approval: "Rejected"
        })
      redirect_to "/admin/applications/#{@application.id}"
    end
  end

  def approve_or_reject_application
    if @all_apps.all?{|app| app.approval == "Approved"}
      @application.application_status = "Approved"
      @application.pets.each do |pet|
        pet.toggle!(:adoptable)
      end
    elsif @all_apps.any?{|app| app.approval == "Rejected"}
      @application.application_status = "Rejected"
    end
  end
end