require 'rails_helper'

describe "As a visitor" do
  describe "When I visit an applications show page /applications/:id" do
    before(:each) do

      @shelter_1 = Shelter.create({
        name: "Crazy Cat Lady's",
        address: "123 Litterbox Way",
        city: "Littleton",
        state: "CO",
        zip: "80110"
      })
      
      @pet_1 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Lizzie",
        description: "Timid and affectionate once she knows you.",
        age: 6,
        sex: "female",
        shelter_id: "#{@shelter_1.id}"
      })

      @pet_2 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Guiness",
        description: "Floppy-eared dude ready to play ball!",
        age: 3,
        sex: "male",
        shelter_id: "#{@shelter_1.id}"
      })
      @pet_3 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Nena",
        description: "In your face and always hungry.",
        age: 9,
        sex: "female",
        shelter_id: "#{@shelter_1.id}"
      })

      @user_1 = User.create({
        name: 'Bobby',
        street_address: '123 fake st.',
        city: 'Fakertown',
        state: 'CO',
        zip: '80205'
      })

      @user_2 = User.create({
        name: 'Jessica',
        street_address: '123 real st.',
        city: 'Realertown',
        state: 'CO',
        zip: '80204'
      })

      @user_3 = User.create({
        name: 'Steve',
        street_address: '1234 fake st.',
        city: 'Fakestown',
        state: 'CO',
        zip: '80113'
      })

      @application_1 = Application.create(
        description: 'I love animals',
        application_status: 'In progress',
        user_id: @user_1.id 
      )

      petapp_1 = PetApplication.create!(
        application_id: @application_1.id,
        pet_id: @pet_1.id 
      )
      
      petapp_2 = PetApplication.create!(
        application_id: @application_1.id,
        pet_id: @pet_2.id 
      )
      
      petapp_3 = PetApplication.create!(
        application_id: @application_1.id,
        pet_id: @pet_3.id 
      )
      
    end 
      it "Then I can see the following:
        - Name of the User on the Application
        - Full Address of the User on the Application
        - Description of why the applicant says they'd be a good home for this pet(s)
        - names of all pets that this application is for (all names of pets should be links to their show page)
        - The Application's status, either In Progress, Pending, Accepted, or Rejected" do

      visit "/applications/#{@application_1.id}"

      expect(page).to have_content("#{@user_1.name}")
      expect(page).to have_content("#{@user_1.street_address}")
      expect(page).to have_content("#{@application_1.description}")
      expect(page).to have_link("#{@pet_1.name}")
      expect(page).to have_link("#{@pet_2.name}")
      expect(page).to have_link("#{@pet_3.name}")
      expect(page).to have_content("#{@application_1.application_status}")
    end
    
    describe "And that application has not been submitted," do    
      it 'I see a section on the page to "Add a Pet to this Application"
      In that section I see an input where I can search for Pets by name
      When I fill in this field with a Pets name
      And I click submit,
      Then I am taken back to the application show page
      And under the search bar I see any Pet whose name matches my search' do
      
      visit "/applications/#{@application_1.id}"
      
      expect(page).to have_content("Add a Pet to this Application")

      end
    end
  end
end