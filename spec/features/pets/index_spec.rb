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

    it "Next to every pet, I see a link to delete that pet. Clicking it takes
        me to the pets index page where I no longer see that pet" do
      visit "/pets"

      expect(page).to have_link("Delete Pet", count: 3)
      find(:xpath, "(//a[text()='Delete Pet'])[3]").click
      expect(page).to_not have_content("#{@pet_3}.image")
      expect(page).to_not have_content("#{@pet_3}.name")
      expect(page).to_not have_content("#{@pet_3}.age")
      expect(page).to_not have_content("#{@pet_3}.sex")
    end

    it "When I click on the name a shelter anywhere on the site
      Then that link takes me to that Shelter's show page" do
      visit "/pets"

      expect(page).to have_link("#{@shelter.name}")
      click_link("#{@shelter.name}", match: :first)
      expect(current_path).to eq("/shelters/#{@shelter.id}")
    end

    it "When I clik on the name of a pet, that link takes me to pet show page" do
      visit "/pets"

      expect(page).to have_link("#{@pet_1.name}")
      expect(page).to have_link("#{@pet_2.name}")
      expect(page).to have_link("#{@pet_3.name}")
      click_link("#{@pet_2.name}")
      expect(current_path).to eq("/pets/#{@pet_2.id}")
    end

    it "To see links to pets index and shelter index" do
      visit "/pets"

      expect(page).to have_link("To Shelters Index")
    end

    it "I see a link to 'Start an Application' that takes me to the new application page" do
      visit "/pets"

      expect(page).to have_link("Start an Application")
      click_link("Start an Application")
      expect(current_path).to eq("/applications/new")
    end
  end
end