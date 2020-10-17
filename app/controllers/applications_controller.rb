class ApplicationsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:user_name])
    @application = Application.new({
      user_id: @user.id,
      description: nil,
      application_status: "In Progress",
      pets: []
      })
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

  def show
    @application = Application.find(params[:application_id])

  end
end