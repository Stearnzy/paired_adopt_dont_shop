require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a shelter's show page" do
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
    end

    it "When on the new review page, I see a form where I must enter title,
        rating, content, user name" do

      visit "/shelters/#{@shelter.id}/review/new"

      fill_in "title", with: "Great place!"
      fill_in "rating", with: 4
      fill_in "content", with: "Can't wait to come back! Louis was awesome!"
      fill_in "user_name", with: "#{@user.name}"

      click_button "Submit"

      expect(current_path).to eq("/shelters/#{@shelter.id}")
      expect(page).to have_content("Great place!")
      expect(page).to have_content("4")
      expect(page).to have_content("Can't wait to come back! Louis was awesome!")
      expect(page).to have_content("Bobby")
    end

    it "I fail to enter a title, a rating, and/or content in the new review form
          but still try to submit, I see a flash message indicating that I need
          to fill in the missing content and I'm returned to the new form" do

        visit "/shelters/#{@shelter.id}/review/new"

        fill_in "title", with: "Love this place"
        fill_in "rating", with: 5
        fill_in "user_name", with: "#{@user.name}"

        click_button "Submit"

        expect(page).to have_content("Review not submitted - title, rating and content required.")
        expect(page).to have_button("Submit")
    end

    it "I enter the name of a User that doesn't exist in the database and I see a
        flash message indicating the user couldn't be found" do

      visit "/shelters/#{@shelter.id}/review/new"

      fill_in "user_name", with: "Steven"
      fill_in "title", with: "Incredible"
      fill_in "rating", with: 4
      fill_in "content", with: "Love all the rescued animals!"

      click_button "Submit"

      expect(page).to have_content("User name does not exist. Please enter a valid user's name.")
      expect(page).to have_button("Submit")
    end
  end
end