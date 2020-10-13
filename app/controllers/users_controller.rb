class UsersController < ApplicationController
  def new

  end

  def create
    user = User.create!({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip]
    })

    redirect_to "/users/#{user.id}"
  end

  def show
    @user = User.find(params[:id])
  end
end