require 'rails_helper'

describe "As a visitor" do
  describe "When I visit '/pets/:id'" do
    it "I see the pet with that id including image, name, description,
        approximate age, sex, and adoptable/pending adoption status" do
      pet_1 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Guiness",
        age: 3,
        sex: "male",
        shelter: "Dog's Haven"
        })

      visit "/pets/#{pet_1.id}"

      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_1.image}")
      expect(page).to have_content("#{pet_1.age}")
      expect(page).to have_content("#{pet_1.sex}")
      expect(page).to have_content("#{pet_1.shelter}")
      expect(page).to have_content("#{pet_1.status}")
    end
  end
end

MUST ADD STATUS TO DATABASE TABLE AND TEST ABOVE!!!!