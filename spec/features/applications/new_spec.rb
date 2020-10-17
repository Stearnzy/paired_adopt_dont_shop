require 'rails_helper'

describe "As a visitor" do
  describe "When I go to '/applications/new'" do
    user = User.create!({
      name: 'Bobby',
      street_address: '123 fake st.',
      city: 'Fakertown',
      state: 'CO',
      zip: '80205'
      })

    it "I see a form to fill in my username and click submit and am taken
      to the new application's show page" do
      visit "/applications/new"

      expect(page).to have_field("user_name")

      fill_in "user_name", with: "Bobby"
      click_on "Submit"

      expect(current_path).to eq("/applications/:id")
    end
  end
end