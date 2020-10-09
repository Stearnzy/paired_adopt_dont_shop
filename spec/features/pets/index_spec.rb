require 'rails_helper'

describe "As a visitor" do
  describe "When I visit '/pets'" do
    it "I see each Pet in the system including image, name, approximate age,
        sex, and name of shelter where pet is currently located" do

      shelter = Shelter.create({
            name: "Dog's Haven",
            address: "123 Litterbox Way",
            city: "Littleton",
            state: "CO",
            zip: "80110"
        })

      pet_1 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Guiness",
        age: 3,
        sex: "male",
        current_shelter: "#{shelter.name}",
        shelter_id: "#{shelter.id}",
        status: "adoptable"
      })

        visit '/pets'

      expect(page).to have_content("Furry Friends Needing a Home")

      expect(page).to have_xpath("//img[contains(@src, '#{pet_1.image}')]")
      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_1.age}")
      expect(page).to have_content("#{pet_1.sex}")
      expect(page).to have_content("#{pet_1.current_shelter}")
    end
  end
end