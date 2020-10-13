require 'rails_helper'

describe "As a visitor" do
  describe "When I am taken to '/users/new'" do
    it "I see a form for a new user to enter name and address" do
      visit "/users/new"

      fill_in "Name", with: "Harry Potter"
      fill_in "Street address", with: "555 Fluffytail Lane"
      fill_in "City", with: "London"
      fill_in "State", with: "NY"
      fill_in "Zip", with: "80563"

      click_button("Create User")
      # expect(current_path).to  eq("/users/#{user.id}")
      expect(page).to have_content("Harry Potter")
      expect(page).to have_content("555 Fluffytail Lane")
      expect(page).to have_content("London")
      expect(page).to have_content("NY")
      expect(page).to have_content("80563")
    end
  end
end