require 'rails_helper'

describe "As a visitor" do
  describe "When I visit '/pets'" do
    it "I see each Pet in the system including image, name, approximate age,
        sex, and name of shelter where pet is currently located" do

      pet_1 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Guiness",
        age: 3,
        sex: "male",
        shelter: "Dog's Haven"
        })

      visit '/pets'

      expect(page).to have_content("Furry Friends Needing a Home")

      # expect(page).to have_content("https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg")
      expect(page).to have_content("Guiness")
      expect(page).to have_content(3)
      expect(page).to have_content("male")
      expect(page).to have_content("Dog's Haven")
    end

  end
end