class ApplicationsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:user_name])

    if @user.nil?
      flash.now[:notice] = "User cannot be found - please try again."
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
    @pet_results = nil
    if params[:search_by_name] != "" && params[:search_by_name] != nil
      @pet_results = @pets.where("lower(name) like ?", "%#{params[:search_by_name]}%".downcase)
    end
  end

  def update
    @application = Application.find(params[:id])

    if params[:description] == ""
      flash.now[:notice] = "Submission failed - must enter why you would make a good owner."
      render :show
    else
      @application.update!({
        description: params[:description],
        application_status: "Pending",
        pets: @application.pets.uniq
        })

      redirect_to "/applications/#{@application.id}"
    end
  end
end