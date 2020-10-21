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

      @user = User.create({
        name: 'Bobby',
        street_address: '123 fake st.',
        city: 'Fakertown',
        state: 'CO',
        zip: '80205'
      })

      @pet_1 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Guiness",
        description: "Floppy-eared dude ready to play ball!",
        age: 3,
        sex: "male",
        shelter_id: "#{@shelter.id}"
      })

      @pet_2 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Nena",
        description: "She is always ready to share some of your food!",
        age: 10,
        sex: "female",
        shelter_id: "#{@shelter.id}"
      })

      # @petapp_1 = PetApplication.create!(
      #   application_id: "#{@application_1.id}",
      #   pet_id: "#{@pet_1.id}",
      #   approval: "Pending"
      # )
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
      expect(page).to have_link("Delete Shelter")
      click_link "Delete Shelter"
      expect(current_path).to eq("/shelters")
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
      # Without photo
      review = Review.create!({
        title: "Great Place!",
        rating: 4,
        content: "Friendly staff, clean establishment",
        user_name: "Karen",
        picture: "",
        shelter_id: "#{@shelter.id}",
        user_id: "#{@user.id}"
        })

      visit "/shelters/#{@shelter.id}"

       expect(page).to have_content("#{review.title}")
       expect(page).to have_content("#{review.rating}")
       expect(page).to have_content("#{review.content}")
       expect(page).to have_content("#{review.user_name}")
       expect(page).to_not have_xpath("//img[contains(@src, '#{review.picture}')]")
    end

    it "I see a list of reviews for that shelter including
     title, rating, content, user name, and optional picture." do
     # With photo

      review = Review.create!({
        title: "Great Place!",
        rating: 4,
        content: "Friendly staff, clean establishment",
        user_name: "Karen",
        picture: "https://unsplash.com/photos/ethVHUKAaEI",
        shelter_id: "#{@shelter.id}",
        user_id: "#{@user.id}"
      })

      visit "/shelters/#{@shelter.id}"

      expect(page).to have_content("#{review.title}")
      expect(page).to have_content("#{review.rating}")
      expect(page).to have_content("#{review.content}")
      expect(page).to have_content("#{review.user_name}")
      expect(page).to have_xpath("//img[contains(@src, '#{review.picture}')]")
      end

    it "I see a link to add a new reivew.  When I click this link
      I am taken to a new review path" do
      visit "/shelters/#{@shelter.id}"

      expect(page).to have_link("Leave a Review")
      click_link("Leave a Review")
      expect(current_path).to eq("/shelters/#{@shelter.id}/review/new")
    end

    it "I see a link to edit the shelter review next to each review. When I click
        this link, I am taken to an edit shelter review path" do

      review = Review.create!({
        title: "Great Place!",
        rating: 4,
        content: "Friendly staff, clean establishment",
        user_name: "Cat Lady",
        picture: "https://face4pets.org/wp-content/uploads/2015/06/shelter-cat2.jpg",
        shelter_id: "#{@shelter.id}",
        user_id: "#{@user.id}"
      })

      visit "/shelters/#{@shelter.id}"
      expect(page).to have_link("Edit Review")
      click_on("Edit Review")
      expect(current_path).to eq("/shelters/#{@shelter.id}/review/#{review.id}/edit")
    end

    it "I see a link next to each shelter review to delete the review." do
      review = Review.create!({
        title: "Great Place!",
        rating: 4,
        content: "Friendly staff, clean establishment",
        user_name: "Carole",
        picture: "https://face4pets.org/wp-content/uploads/2015/06/shelter-cat2.jpg",
        shelter_id: "#{@shelter.id}",
        user_id: "#{@user.id}"
        })
        visit "/shelters/#{@shelter.id}"
        expect(page).to have_link("Delete Review")
        click_link("Delete Review")

        expect(page).to_not have_content("#{review.title}")
        expect(page).to_not have_content("#{review.rating}")
        expect(page).to_not have_content("#{review.content}")
        expect(page).to_not have_content("#{review.user_name}")
        expect(page).to_not have_content("#{review.picture}")
    end

    it 'I see statistics for that shelter, including:
        - count of pets that are at that shelter
        - average shelter review rating
        - number of applications on file for that shelter' do
        
    review_1 = Review.create!({
      user_name: "Bobby",
      title: "Love this place",
      rating: 5,
      content: "Great staff all around",
      shelter_id: "#{@shelter.id}",
      user_id: "#{@user.id}"
      })

    review_2 = Review.create!({
      user_name: "Bobby",
      title: "Dogs are OK",
      rating: 2,
      content: "One peed on my leg",
      shelter_id: "#{@shelter.id}",
      user_id: "#{@user.id}"
      })

    review_3 = Review.create!({
      user_name: "Bobby",
      title: "Bird crap everywhere",
      rating: 1,
      content: "Worst ever.",
      shelter_id: "#{@shelter.id}",
      user_id: "#{@user.id}"
      })
    
    visit "/shelters/#{@shelter.id}"

    within "#count" do
      expect(page).to have_content("Number of Pets: #{@shelter.pet_count}")  
    # expect(page).to have_content("#{@shelter.review_average}")  
    # expect(page).to have_content("#{@shelter.application_count}")  
      end 
    end
  end
end