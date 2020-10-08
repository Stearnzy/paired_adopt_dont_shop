require 'rails_helper'

describe "As a user" do
  describe "I am taken to '/shelters/:id/edit'" do
    it "where I see a form to edit the shelter's data" do
      shelter = Shelter.create({
            name: "Crazy Cat Lady's",
            address: "123 Litterbox Way",
            city: "Littleton",
            state: "CO",
            zip: "80110"
        })
require "pry"; binding.pry
    end
  end
end