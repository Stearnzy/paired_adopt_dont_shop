class ApplicationsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:user_name])

    if @user.nil?
      flash[:notice] = "User cannot be found - please try again."
      render :new
    else
      application_creation
    end
  end

  def application_creation
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

  def update
    @application = Application.find(params[:id])
    @application.update({
      user_id: params[:user_id],
      description: params[:description],
      application_status: "Pending",
      pets: params[:pets]
      })
require "pry"; binding.pry
  end
end