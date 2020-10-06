class SheltersController < ApplicationController
  def index
    @shelters = ['Dumb Friends League', 'Max Fund', 'House for Cats']
  end
end