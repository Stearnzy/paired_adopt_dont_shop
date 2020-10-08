require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/shelters'" do
    it "then I see the name of each shelter in the system" do
      shelter_1 = Shelter.create({
            name: "Crazy Cat Lady's",
            address: "123 Litterbox Way",
            city: "Littleton",
            state: "CO",
            zip: "80110"
        })
      shelter_2 = Shelter.create({
            name: "Perky Parakeets",
            address: "333 S Tropicana St.",
            city: "Las Vegas",
            state: "NV",
            zip: "66666"
        })

      visit '/shelters'

      expect(page).to have_content("Our Family of Shelters")
      expect(page).to have_content("#{shelter_1.name}")
      expect(page).to have_content("#{shelter_2.name}")
    end

    it "I see a link to create a new shelter" do
      visit '/shelters'
      
      expect(page).to have_link("New Shelter")
    end
  end
end