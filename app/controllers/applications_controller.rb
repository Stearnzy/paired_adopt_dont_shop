class ApplicationsController < ApplicationController
  def new
  end

  def create
    application = Application.new
  end

  def show
    @application = Application.find(params[:application_id])
  end
end