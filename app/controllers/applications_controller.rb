class ApplicationsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:user_name])
    # require 'pry'; binding.pry
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
      @pets = Pet.all
    @pet_results =[]
    if params[:search_by_name] != "" && params[:search_by_name] != nil
      @pet_results = @pets.where("lower(name) like ?", "%#{params[:search_by_name]}%".downcase)
    end
  end
end