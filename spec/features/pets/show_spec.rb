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

      @pet_2 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Nena",
        description: "She is always ready to share some of your food!",
        age: 10,
        sex: "female",
        shelter_id: "#{@shelter.id}"
        })

      @user_1 = User.create({
        name: 'Bobby',
        street_address: '123 fake st.',
        city: 'Fakertown',
        state: 'CO',
        zip: '80205'
      })

      @application_1 = Application.create(
        user_id: "#{@user_1.id}",
        application_status: 'In Progress',
      )

      @petapp_1 = PetApplication.create!(
        application_id: "#{@application_1.id}",
        pet_id: "#{@pet_1.id}",
        approval: "Pending"
      )

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

    it "I see a link to view all applications for this pet
      When I click that link
      I can see a list of all the names of applicants for this pet
      Each applicants name is a link to the application's show page" do 
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_link("View Applications")

      click_on("View Applications")

      expect(page).to have_content("#{@user_1.name}'s Application")  
    end

    it 'When I visit a pet applications index page for a pet that has no applications on them
        I see a message saying that there are no applications for this pet yet' do

        visit "/pets/#{@pet_2.id}"

        click_on("View Applications")

        expect(page).to have_content("This pet has no open applications yet!")
    end
  end
end
