require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/shelters/:id'" do
    before(:each) do
      @shelter = Shelter.create({
        name: "Crazy Cat Lady's",
        address: "123 Litterbox Way",
        city: "Littleton",
        state: "CO",
        zip: "80110"
        })

      end

    it "I see the shelter with that id including the shelter's
          name, address, city, state, and zip" do
      visit "/shelters/#{@shelter.id}"

      expect(page).to have_link("Shelter Index")
      expect(page).to have_content("#{@shelter.name}")
      expect(page).to have_content("#{@shelter.address}")
      expect(page).to have_content("#{@shelter.city}")
      expect(page).to have_content("#{@shelter.state}")
      expect(page).to have_content("#{@shelter.zip}")
    end

    it "I see a link to update the shelter" do
      visit "/shelters/#{@shelter.id}"
      expect(page).to have_link("Update Shelter")
    end

    it "I see a link to delete the shelter" do
      visit "/shelters/#{@shelter.id}"
      expect(page).to have_button("Delete")
    end

    it "I see a link to take me to that shelter's pets page" do
      visit "/shelters/#{@shelter.id}"

      expect(page).to have_link("See Pets")
      click_link("See Pets")
      expect(current_path).to eq("/shelters/#{@shelter.id}/pets")
    end
  end
end