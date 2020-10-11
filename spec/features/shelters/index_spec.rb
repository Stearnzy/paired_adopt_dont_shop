require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/shelters'" do
    before(:each) do
      @shelter_1 = Shelter.create({
            name: "Crazy Cat Lady's",
            address: "123 Litterbox Way",
            city: "Littleton",
            state: "CO",
            zip: "80110"
        })
      @shelter_2 = Shelter.create({
            name: "Perky Parakeets",
            address: "333 S Tropicana St.",
            city: "Las Vegas",
            state: "NV",
            zip: "66666"
        })
    end

    it "then I see the name of each shelter in the system" do
      visit '/shelters'

      expect(page).to have_content("Our Family of Shelters")
      expect(page).to have_content("#{@shelter_1.name}")
      expect(page).to have_content("#{@shelter_2.name}")
    end

    it "I see a link to create a new shelter" do
      visit '/shelters'

      expect(page).to have_link("New Shelter")
    end

    it "Next to every shelter I see a link to edit that shelter's info.  When I
        click the link I should be taken to that shelter's edit page" do
      visit '/shelters'

      expect(page).to have_link("Edit Shelter", count: 2)
      find(:xpath, "(//a[text()='Edit Shelter'])[2]").click
      expect(current_path).to eq("/shelters/#{@shelter_2.id}/edit")
    end

    it "Next to every shelter I see a link to delete that shelter.  When I click
        the link, I am returned to the Shelter Index Page" do
      visit '/shelters'

      expect(page).to have_link("Delete", count: 2)
      find(:xpath, "(//a[text()='Delete'])[2]").click
      expect(page).to_not have_content("#{@shelter_2.name}")
    end
  end
end