class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    require "pry"; binding.pry
  end

  def update

  end

end