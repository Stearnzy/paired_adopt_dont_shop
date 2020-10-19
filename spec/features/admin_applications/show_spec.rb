require 'rails_helper'

describe "As a visitor" do
  describe "When I visit an admin application show page ('/admin/applications/:id')" do 
    it 'For every pet that the application is for, I see a button to approve the application for that specific pet
        When I click that button
        Then Im taken back to the admin application show page
        And next to the pet that I approved, I do not see a button to approve this pet
        And instead I see an indicator next to the pet that they have been approved' do
      
      @shelter_1 = Shelter.create({
        name: "Crazy Cat Lady's",
        address: "123 Litterbox Way",
        city: "Littleton",
        state: "CO",
        zip: "80110"
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

      @pet_1 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Lizzie",
        description: "Timid and affectionate once she knows you.",
        age: 6,
        sex: "female",
        shelter_id: "#{@shelter_1.id}"
      })

      @petapp_1 = PetApplication.create!(
        application_id: @application_1.id,
        pet_id: @pet_1.id
      )

      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_button("Approve Application")

      click_button "Approve Application"

      expect(path).to eq("/admin/applications/#{@application_1.id}")

      expect(page).to have_content("Application Approved")
      expect(page).to_not have_content("Approve Application")

    end
  end
end