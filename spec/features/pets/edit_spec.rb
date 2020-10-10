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
  end
end

# As a visitor
# When I visit a Pet Show page
# Then I see a link to update that Pet "Update Pet"
# When I click the link
# I am taken to '/pets/:id/edit' where I see a form to edit the pet's data including:
# - image
# - name
# - description
# - approximate age
# - sex
# When I click the button to submit the form "Update Pet"
# Then a `PATCH` request is sent to '/pets/:id',
# the pet's data is updated,
# and I am redirected to the Pet Show page where I see the Pet's updated information