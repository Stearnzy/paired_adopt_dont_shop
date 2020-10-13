require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a shelter's show page" do
    it "I see a link to add a new review that takes me to a new review path" do
      visit "/shelters/#{shelter.id}"

      expect(page).to have_link("Leave a Review")
      click_link("Leave a Review")
      expect(current_path).to eq("/shelters/#{@shelter.id}/review/new")
    end

    it "I see a form where I must enter title, rating, content, user name" do
      shelter = Shelter.create({
        name: "Crazy Cat Lady's",
        address: "123 Litterbox Way",
        city: "Littleton",
        state: "CO",
        zip: "80110"
        })

      user = User.create({
        name: 'Bobby',
        street_address: '123 fake st.',
        city: 'Fakertown',
        state: 'CO',
        zip: '80205'
      })

      visit "/shelters/#{shelter.id}"

      fill_in "title", with: "Great place!"
      fill_in "rating", with: 4
      fill_in "content", with: "Can't wait to come back! Louis was awesome!"
      fill_in "user_name", with: "#{user.name}"

      click_button "Submit"

      expect(current_path).to eq("/shelters/#{shelter.id}")
      expect(page).to have_content("Great place!")
      expect(page).to have_content("4")
      expect(page).to have_content("Can't wait to come back! Louis was awesome!")
      expect(page).to have_content("#{user.name}")
    end


  end
end