class AdminApplicationsController < ApplicationController
  def show 
    @application = Application.find_by(application_id: params[:application_id])
    @application
  end

  def update

  end
  
end