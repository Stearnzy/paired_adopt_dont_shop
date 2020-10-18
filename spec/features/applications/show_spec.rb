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

      @application_1 = Application.create(
        user_id: @user_1.id,
        application_status: 'In Progress',
        pets: []
      )
    end
      it "Then I can see the following:
        - Name of the User on the Application
        - Full Address of the User on the Application
        - Description of why the applicant says they'd be a good home for this pet(s)
        - names of all pets that this application is for (all names of pets should be links to their show page)
        - The Application's status, either In Progress, Pending, Accepted, or Rejected" do

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

      visit "/applications/#{@application_1.id}"

      expect(page).to have_content("#{@user_1.name}")
      expect(page).to have_content("#{@user_1.street_address}")
      expect(page).to have_content("#{@application_1.description}")
      expect(page).to have_link("#{@pet_1.name}")
      expect(page).to have_link("#{@pet_2.name}")
      expect(page).to have_link("#{@pet_3.name}")
      expect(page).to have_content("#{@application_1.application_status}")
    end

    it "Filling in user name on new application page and click submit, I am taken to
        the new app's show page and see my user listed with address information
        and see that application is In Progress" do
      visit "/applications/new"

      fill_in "user_name", with: "#{@user_1.name}"
      click_on "Submit"

      expect(page).to have_content("#{@user_1.name}")
      expect(page).to have_content("#{@user_1.street_address}")
      expect(page).to have_content("#{@user_1.city}")
      expect(page).to have_content("#{@user_1.state}")
      expect(page).to have_content("#{@user_1.zip}")
      expect(page).to have_content("In Progress")
    end

    describe "And that application has not been submitted," do
      it 'I see a section on the page to "Add a Pet to this Application"
        In that section I see an input where I can search for Pets by name
        When I fill in this field with a Pets name
        And I click submit,
        Then I am taken back to the application show page
        And under the search bar I see any Pet whose name matches my search' do

        visit "/applications/new"

        fill_in "user_name", with: "#{@user_1.name}"
        click_on "Submit"

        expect(page).to have_content("Application for Adoption")
        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to_not have_content("Lizzie")

        fill_in :search_by_name, with: "Lizzie"
        click_button("Search")

        expect(page).to have_content("Application for Adoption")
        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to have_content("Lizzie")
      end
    end

    describe "When I search for a Pet by name and I see the names of Pets that
      match my search" do
      it "Then next to each Pet's name I see a button to Adopt this Pet" do
        visit "/applications/#{@application_1.id}"

        fill_in :search_by_name, with: "#{@pet_2.name}"
        click_button "Search"

        within "#search-results" do
          expect(page).to have_link("#{@pet_2.name}")
          expect(page).to have_button("Adopt this Pet")
        end
      end

      it "Even return results where the name partially matches my search" do
        visit "/applications/#{@application_1.id}"

        fill_in :search_by_name, with: "Gui"
        click_button "Search"

        within "#search-results" do
          expect(page).to have_link("#{@pet_2.name}")
        end
      end

      it "When I click Adopt this pet, I am taken back to the application show
          page and see the pet I want to adopt listed on the application" do
        visit "/applications/#{@application_1.id}"

        fill_in :search_by_name, with: "#{@pet_3.name}"
        click_button "Search"

        within "#pets-of-interest" do
          expect(page).to_not have_link("#{@pet_3.name}")
        end

        within "#search-results" do
          click_button "Adopt this Pet"
        end

        expect(current_path).to eq("/applications/#{@application_1.id}")
        within "#pets-of-interest" do
          expect(page).to have_link("#{@pet_3.name}")
        end
      end
    end

    describe "When I have added one or more pets to applicaton," do
      it "I see a section to submit my application including input for why I
          make a good owner " do
        visit "/applications/#{@application_1.id}"

        expect(page).to_not have_content("Why you would make a good owner:")

        fill_in :search_by_name, with: "#{@pet_3.name}"
        click_button "Search"
        click_button "Adopt this Pet"

        expect(page).to have_content("Why you would make a good owner:")
        expect(page).to have_button("Submit Application")
      end

      it "When I fill in that input and click submit, I am taken back to application
          show page and see and indicator that the app is pending, all the pets I
          want to adopt, and I do not see a section to add more pets" do
        visit "/applications/#{@application_1.id}"

        fill_in :search_by_name, with: "#{@pet_1.name}"
        click_button "Search"
        click_button "Adopt this Pet"

        fill_in :search_by_name, with: "#{@pet_2.name}"
        click_button "Search"
        click_button "Adopt this Pet"

        fill_in :description, with: "I have taken care of pets for years and love
                                    the mix of male and female cats and dogs!"
        click_button "Submit Application"

        expect(page).to have_content("Application for Adoption")
        expect(page).to have_content("Pending")

        expect(page).to_not have_content("In Progress")
        expect(page).to_not have_content("Add a Pet to this Application")
        expect(page).to_not have_button("Search")
      end
    end

    it "I have not added any pets to the application, so I do not see a section
        to submit my application" do
      visit "/applications/#{@application_1.id}"

      expect(page).to_not have_field(:description)
      expect(page).to_not have_button "Submit Application"
    end

    it "I have added one or more pets but fail to enter why I make a good owner,
        I'm taken back to the show page and see flash that the field must be filled
        before submission.  Application is still In Progress" do
      visit "/applications/#{@application_1.id}"

      fill_in :search_by_name, with: "#{@pet_2.name}"
      click_button "Search"
      click_button "Adopt this Pet"

      click_button "Submit Application"
      expect(page).to have_content("In Progress")
      expect(page).to have_content("Submission failed - must enter why you would make a good owner.")
    end
  end
end