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

      @shelter_2 = Shelter.create({
        name: "Dog's Haven",
        address: "444 Dog Park Rd.",
        city: "Denver",
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
        shelter_id: "#{@shelter_2.id}"
      })

      @pet_2 = Pet.create({
        image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.ktvb.com%2Farticle%2Fentertainment%2Fplaces%2Fidaho-life%2Fidaho-life-boise-woman-finds-niche-as-pho-dog-grapher%2F277-d6456b15-6b2a-4bad-9b25-eeb58faf1323&psig=AOvVaw3hm5tZEVkZl17MKIwo9X_I&ust=1603338603299000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODUzvHjxOwCFQAAAAAdAAAAABAD",
        name: "Nena",
        description: "She is always ready to share some of your food!",
        age: 10,
        sex: "female",
        shelter_id: "#{@shelter.id}"
      })

      @pet_3 = Pet.create({
        image: 'https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg',
        name: "Garfield",
        description: "Ready and willing to eat your lasagna.",
        age: 13,
        sex: "male",
        shelter_id: "#{@shelter.id}"
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

    it "I see statistics for that shelter, including:
        - count of pets that are at that shelter" do
      visit "/shelters/#{@shelter.id}"

      within "#count" do
        expect(page).to have_content("Number of Pets: #{@shelter.pet_count}")
      end
    end

    it "I see the average shelter review rating" do
      review_1 = Review.create!({
        user_name: "Bobby",
        title: "Great customer service",
        rating: 5,
        picture: "https://face4pets.org/wp-content/uploads/2015/06/shelter-cat2.jpg",
        content: "Great staff all around",
        shelter_id: "#{@shelter.id}",
        user_id: "#{@user.id}"
        })

      review_2 = Review.create!({
        user_name: "Bobby",
        title: "Clean up a little",
        rating: 4,
        picture: 'https://www.treehugger.com/thmb/69yZbhJR6bzhORevUYoLRX_pHSQ=/640x480/filters:fill(auto,1)/__opt__aboutcom__coeus__resources__content_migration__mnn__images__2016__04__IMG_4146-6db7307bdc4447d0bd152df2c5d4c68b.JPG',
        content: "Some litter spots in areas.  Not bad though!",
        shelter_id: "#{@shelter.id}",
        user_id: "#{@user.id}"
        })

      review_3 = Review.create!({
        user_name: "Bobby",
        title: "Beautiful cats",
        rating: 4,
        picture: 'https://cdn.omlet.co.uk/images/originals/Cat-Cat_Guide-A_litter_of_six_black_and_white_kittens.jpg',
        content: "Gorgeous kittens!",
        shelter_id: "#{@shelter.id}",
        user_id: "#{@user.id}"
        })

      visit "/shelters/#{@shelter.id}"

      within "#avg-customer-reviews" do
        expect(page).to have_content("Average Customer Reviews: 4.3")
      end
    end

    it "I see the number of applications on file for that shelter" do
      application_1 = Application.create!({
        user_id: @user.id,
        description: nil,
        application_status: "In Progress"
        })

      application_2 = Application.create!({
        user_id: @user.id,
        description: nil,
        application_status: "In Progress"
        })

      petapp_2 = PetApplication.create!(
        application_id: "#{application_2.id}",
        pet_id: "#{@pet_1.id}",
        approval: "Pending"
      )

      petapp_2 = PetApplication.create!(
        application_id: "#{application_1.id}",
        pet_id: "#{@pet_2.id}",
        approval: "Pending"
      )

      petapp_3 = PetApplication.create!(
        application_id: "#{application_1.id}",
        pet_id: "#{@pet_3.id}",
        approval: "Pending"
      )
require "pry"; binding.pry
      within "#app-count" do
        expect(page).to have_content("Active Applications: 2")
      end
    end
  end
end