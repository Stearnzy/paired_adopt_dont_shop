require 'rails_helper'

describe "As a user" do
  describe "when visiting main page" do
    it "I see buttons to view shelters and pets" do
      visit "/"

      expect(page).to have_link("Pets")
      expect(page).to have_link("Shelters")
    end
  end
end