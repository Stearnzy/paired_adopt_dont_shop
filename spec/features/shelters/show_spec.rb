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

      expect(page).to have_link("See Our Pets")
      click_link("See Our Pets")
      expect(current_path).to eq("/shelters/#{@shelter.id}/pets")
    end

    it "To see links to pets index and shelter index" do
      visit "/shelters/#{@shelter.id}"

      expect(page).to have_link("To Pets Index")
      expect(page).to have_link("To Shelters Index")
    end

    it "I see a list of reviews for that shelter including
     title, rating, content, user name, and optional picture." do 
     visit "shelters/#{@shelter.id}"

    user = User.create({
      name: 'Bobby',
      street_address: '123 fake st.',
      city: 'Fakertown',
      state: 'CO',
      zip: '80205'
    })

    review = Review.create!({
      title: "Great Place!",
      rating: 4,
      content: "Friendly staff, clean establishment",
      user_name: "Cat Lady",
      picture: "https://unsplash.com/photos/ethVHUKAaEI",
      shelter_id: "#{@shelter.id}",
      user_id: "#{user.id}"
    })

      expect(page).to have_content("#{review.title}")
      expect(page).to have_content("#{review.rating}")
      expect(page).to have_content("#{review.content}")
      expect(page).to have_content("#{review.user_name}")
      expect(page).to have_content("#{review.picture}")

     end

  end
end