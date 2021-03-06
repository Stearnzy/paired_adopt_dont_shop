require 'rails_helper'

describe "As a user" do
  describe "I am taken to '/shelters/:id/edit'" do
    before(:each) do
      @shelter = Shelter.create({
        name: "Crazy Cat Lady's",
        address: "123 Litterbox Way",
        city: "Littleton",
        state: "CO",
        zip: "80123"
        })
    end

    it "where I see a form to edit the shelter's data" do
      visit "/shelters/#{@shelter.id}"

      click_link "Update Shelter"
      expect(current_path).to eq("/shelters/#{@shelter.id}/edit")

      expect(page).to have_content("Edit Shelter:")
      expect(find_field('shelter[name]').value).to eq("Crazy Cat Lady's")
      expect(find_field('shelter[address]').value).to eq("123 Litterbox Way")
      expect(find_field('shelter[city]').value).to eq("Littleton")
      expect(find_field('shelter[state]').value).to eq("CO")
      expect(find_field('shelter[zip]').value).to eq("80123")

      fill_in "shelter[city]", with: "Denver"
      expect(find_field('shelter[city]').value).to eq('Denver')

      click_button('submit')
      expect(current_path).to eq("/shelters/#{@shelter.id}")

      expect(page).to have_content("#{@shelter.name}")
      expect(page).to have_content("#{@shelter.address}")
      expect(page).to have_content("Denver")
      expect(page).to have_content("#{@shelter.state}")
      expect(page).to have_content("#{@shelter.zip}")
    end

    it "To see links to pets index and shelter index" do
      visit "/shelters/#{@shelter.id}/edit"

      expect(page).to have_link("To Pets Index")
      expect(page).to have_link("To Shelters Index")
    end
  end
end