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

      expect(page).to have_field("user_name")

      fill_in "user_name", with: "Bobby"
      click_on "Submit"

  save_and_open_page
      # expect(current_path).to eq("/applications/#{@application.id}")
    end
  end
end