require 'rails_helper'

describe "As a visitor" do
  describe "When I go to '/applications/new'" do
    it "I see a form to fill in my username and click submit and am taken
      to the new application's show page" do

      user = User.create!({
        name: 'Bobby',
        street_address: '123 fake st.',
        city: 'Fakertown',
        state: 'CO',
        zip: '80205'
        })
      visit "/applications/new"

      expect(page).to have_content("New Application")
      expect(page).to have_content("Enter your username:")
      expect(page).to have_field("user_name")

      fill_in "user_name", with: "Bobby"
      click_on "Submit"

      expect(page).to have_content("In Progress")
    end

    it "I fill in the form with the name of a user that doesn't exist in the
      database and click submit, I'm taken back to the new application page
      and see a message that the user cannot be found" do
      visit "/applications/new"

      expect(page).to have_field("user_name")

      fill_in "user_name", with: "Stewart"
      click_on "Submit"

      expect(page).to have_content("User cannot be found - please try again.")
      expect(page).to have_content("New Application")
      expect(page).to have_field("user_name")
    end
  end
end