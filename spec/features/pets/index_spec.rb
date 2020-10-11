require 'rails_helper'

describe "As a visitor" do
  describe "When I visit '/pets'" do
    before(:each) do
      @shelter = Shelter.create({
            name: "Dog's Haven",
            address: "123 Litterbox Way",
            city: "Littleton",
            state: "CO",
            zip: "80110"
        })

      @pet_1 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Guiness",
        age: 3,
        sex: "male",
        description: "description",
        shelter_id: "#{@shelter.id}",
      })

      @pet_2 = Pet.create({
        image: "https://i.guim.co.uk/img/media/fe1e34da640c5c56ed16f76ce6f994fa9343d09d/0_174_3408_2046/master/3408.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=0d3f33fb6aa6e0154b7713a00454c83d",
        name: "Sugar",
        age: 5,
        sex: "Female",
        description: "description",
        shelter_id: "#{@shelter.id}"
        })

      @pet_3 = Pet.create({
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQJQAu8ee6hG7lIozSyQJKgXGcFu236FAbNOw&usqp=CAU",
        name: "Gus",
        age: 11,
        sex: "Male",
        description: "description",
        shelter_id: "#{@shelter.id}"
        })
    end

    it "I see each Pet in the system including image, name, approximate age,
        sex, and name of shelter where pet is currently located" do
        visit '/pets'

      expect(page).to have_content("Furry Friends Needing a Home")

      expect(page).to have_xpath("//img[contains(@src, '#{@pet_1.image}')]")
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_content("#{@pet_1.age}")
      expect(page).to have_content("#{@pet_1.sex}")
      expect(page).to have_content("#{@shelter.name}")
    end

    it "Next to each pet I see a link to edit pet's info.  When I click it,
        I am taken to the pet's edit page" do
      visit "/pets"

      expect(page).to have_link("Edit Pet Info", count: 3)
      find(:xpath, "(//a[text()='Edit Pet Info'])[3]").click
      expect(current_path).to eq("/pets/#{@pet_3.id}/edit")
    end
  end
end