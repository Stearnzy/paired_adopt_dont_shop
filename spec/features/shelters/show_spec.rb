require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/shelters/:id'" do
    it "I see the shelter with that id including the shelter's
          name, address, city, state, and zip" do
      shelter = Shelter.create({
            name: "Crazy Cat Lady's",
            address: "123 Litterbox Way",
            city: "Littleton",
            state: "CO",
            zip: "80110"
        })
      visit "/shelters/#{shelter.id}"

      expect(page).to have_link("Shelter Index")
      expect(page).to have_content("#{shelter.name}")
      expect(page).to have_content("#{shelter.address}")
      expect(page).to have_content("#{shelter.city}")
      expect(page).to have_content("#{shelter.state}")
      expect(page).to have_content("#{shelter.zip}")

      expect(page).to have_link("Edit")
      expect(page).to have_button("Delete")
    end
  end
end