class AdminApplicationsController < ApplicationController
  def show 
    @application = Application.find_by(params[:application_status])
    @application
  end

  def update

  end
  
end