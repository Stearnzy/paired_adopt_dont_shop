require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a Pet Show page, Then I see a link to update that pet" do
    before(:each) do
      @shelter = Shelter.create({
        name: "Perky Parakeets",
        address: "666 Tropicana Way",
        city: "Las Vegas",
        state: "NV",
        zip: "66666"
        })

      @pet = Pet.create({
        image: "https://media.angieslist.com/s3fs-public/styles/widescreen_large/public/parakeet.jpeg?itok=2pMpm55J",
        name: "Perry",
        description: "Beautiful golden bird, ready to party!",
        age: 7,
        sex: "Female",
        shelter_id: "#{@shelter.id}"
        })
    end

    it "When I click the link I am taken to '/pets/:id/edit' where I see a form" do

      visit "/pets/#{@pet.id}"
      click_link "Update Pet"
      expect(current_path).to eq("/pets/#{@pet.id}/edit")
    end

    it "To edit the pet's data including image, name, description, age, sex.  When
        I click the button to submit, data is updated" do

        visit "/pets/#{@pet.id}/edit"

        expect(page).to have_content("Edit Pet:")
        expect(find_field('pet[image]').value).to eq("https://media.angieslist.com/s3fs-public/styles/widescreen_large/public/parakeet.jpeg?itok=2pMpm55J")
        expect(find_field('pet[name]').value).to eq("Perry")
        expect(find_field('pet[description]').value).to eq("Beautiful golden bird, ready to party!")
        expect(find_field('pet[age]').value).to eq("7")
        expect(find_field('pet[sex]').value).to eq("Female")
        expect(page).to have_button("submit")

        fill_in "pet[name]", with: "Polly"
        expect(find_field('pet[name]').value).to eq("Polly")

        click_button("submit")
        expect(current_path).to eq("/pets/#{@pet.id}")
    end
  end
end