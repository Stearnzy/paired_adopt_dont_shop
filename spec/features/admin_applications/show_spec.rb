require 'rails_helper'

describe "As a visitor" do
  describe "When I visit an admin application show page ('/admin/applications/:id')" do
    before(:each) do
      @shelter_1 = Shelter.create({
        name: "Crazy Cat Lady's",
        address: "123 Litterbox Way",
        city: "Littleton",
        state: "CO",
        zip: "80110"
      })

      @shelter_2 = Shelter.create({
        name: "Dog's Haven",
        address: "226 Woof Rd.",
        city: "Granby",
        state: "CO",
        zip: "85465"
      })

      @user_1 = User.create({
        name: 'Bobby',
        street_address: '123 fake st.',
        city: 'Fakertown',
        state: 'CO',
        zip: '80205'
      })

      @user_2 = User.create({
        name: "Sarah",
        street_address: '444 Lonely Ln.',
        city: 'Seattle',
        state: 'WA',
        zip: '90256'
        })

      @application_1 = Application.create(
        user_id: "#{@user_1.id}",
        application_status: 'In Progress',
      )

      @application_2 = Application.create(
        user_id: "#{@user_2.id}",
        application_status: 'In Progress',
      )

      @pet_1 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Lizzie",
        description: "Timid and affectionate once she knows you.",
        age: 6,
        sex: "female",
        shelter_id: "#{@shelter_1.id}",
        adoptable: true
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

      # @pet_4 = Pet.create({
      #   image: "https://www.guidedogs.org/wp-content/uploads/2019/11/website-donate-mobile.jpg",
      #   name: "Gus",
      #   description: "Always sittin' pretty.",
      #   age: 4,
      #   sex: "male",
      #   shelter_id: "#{@shelter_2.id}"
      #   })

      @petapp_1 = PetApplication.create!(
        application_id: "#{@application_2.id}",
        pet_id: "#{@pet_1.id}",
        approval: "Pending"
      )

      @petapp_2 = PetApplication.create!(
        application_id: "#{@application_1.id}",
        pet_id: "#{@pet_2.id}",
        approval: "Pending"
      )

      @petapp_3 = PetApplication.create!(
        application_id: "#{@application_1.id}",
        pet_id: "#{@pet_3.id}",
        approval: "Pending"
      )

      @petapp_4 = PetApplication.create!({
        application_id: "#{@application_1.id}",
        pet_id: "#{@pet_1.id}",
        approval: "Pending"
        })
    end

    it "For every pet that the application is for, I see a button to approve the application for that specific pet" do
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_button("Approve Pet", count: 3)
    end

    it "When I click that button Then Im taken back to the admin application show page
        And next to the pet that I approved, I do not see a button to approve this pet
        And instead I see an indicator next to the pet that they have been approved" do
      visit "/admin/applications/#{@application_1.id}"

      click_button("Approve Pet", match: :first)

      expect(page).to have_content("Pet Approved")
      expect(page).to have_button("Approve Pet", count: 2)
    end

    it "For every pet that the application is for, I see a button to reject the
        application for that specific pet" do
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_button("Reject Pet", count: 3)
    end

    it "When I click that button Then I'm taken back to the admin application
        show page And next to the pet that I rejected, I do not see a button to
        approve or reject this pet And instead I see an indicator next to the
        pet that they have been rejected" do
      visit "/admin/applications/#{@application_1.id}"

      click_button("Reject Pet", match: :first)

      expect(page).to have_content("Pet Rejected")
      expect(page).to have_button("Reject Pet", count: 2)
    end

    it "If I approve all pets for an app then I am taken back to the admin application
        show page and see the app's status changed to Approved" do
      visit "/admin/applications/#{@application_1.id}"

      click_button("Approve Pet", match: :first)
      click_button("Approve Pet", match: :first)
      click_button("Approve Pet", match: :first)

      expect(page).to have_content("Application Approved")
    end

    it "If I reject one or more pets for an app then I am taken back to the admin application
        show page and see the app's status changed to Rejected" do
      visit "/admin/applications/#{@application_1.id}"

      click_button("Reject Pet", match: :first)
      click_button("Approve Pet", match: :first)
      click_button("Approve Pet", match: :first)

      expect(page).to have_content("Application Rejected")
    end

    it "When a pet has an Approved app on them and I visit the admin show page of
        another application that is pending on the same pet, I do not see a button
        next to the pet.  Instead I see a message that this pet has been approved" do

      visit "/admin/applications/#{@application_2.id}"

      within "#pet-app-#{@petapp_1.id}" do
        click_button "Approve Pet"
      end

      visit "/admin/applications/#{@application_1.id}"

      within "#pet-app-#{@petapp_4.id}" do
        expect(page).to_not have_button("Approve Pet")
        expect(page).to_not have_button("Reject Pet")
        expect(page).to have_content("This pet has already been approved for adoption.")
      end
    end
  end
end