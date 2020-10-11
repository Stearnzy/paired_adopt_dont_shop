require 'rails_helper'

describe "As a visitor" do
  describe "When I visit '/pets/:id'" do
    before(:each) do
      @shelter = Shelter.create({
        name: "Crazy Cat Lady's",
        address: "123 Litterbox Way",
        city: "Littleton",
        state: "CO",
        zip: "80110"
        })


      @pet_1 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Guiness",
        description: "Floppy-eared dude ready to play ball!",
        age: 3,
        sex: "male",
        shelter_id: "#{@shelter.id}"
        })

    end

    it "I see the pet with that id including image, name, description,
        approximate age, sex, and adoptable/pending adoption status" do

      visit "/pets/#{@pet_1.id}"

      expect(page).to have_xpath("//img[contains(@src, '#{@pet_1.image}')]")
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_content("#{@pet_1.description}")
      expect(page).to have_content("#{@pet_1.age}")
      expect(page).to have_content("#{@pet_1.sex}")
      expect(page).to have_content("Adoptable")

      expect(page).to have_link("Update Pet")
      click_on "Update Pet"
      expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    end

    it "I see a link to delete the pet"do
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_link("Delete")
    end

    it "When I click delete, pet is deleted and redirected to pet index" do
      visit "/pets/#{@pet_1.id}"

      click_on "Delete Pet"
      expect(current_path).to eq("/pets")
      expect(page).to_not have_content("#{@pet_1.name}")
    end

    it "To see links to pets index and shelter index" do
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_link("To Pets Index")
      expect(page).to have_link("To Shelters Index")
    end
  end
end
