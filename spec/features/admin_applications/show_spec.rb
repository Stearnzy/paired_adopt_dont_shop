require 'rails_helper'

describe "As a visitor" do
  describe "When I visit an admin application show page ('/admin/applications/:id')" do
    it "For every pet that the application is for, I see a button to approve the application for that specific pet
        When I click that button
        Then Im taken back to the admin application show page
        And next to the pet that I approved, I do not see a button to approve this pet
        And instead I see an indicator next to the pet that they have been approved" do

      shelter_1 = Shelter.create({
        name: "Crazy Cat Lady's",
        address: "123 Litterbox Way",
        city: "Littleton",
        state: "CO",
        zip: "80110"
      })

      shelter_2 = Shelter.create({
        name: "Dog's Haven",
        address: "226 Woof Rd.",
        city: "Granby",
        state: "CO",
        zip: "85465"
      })

      user_1 = User.create({
        name: 'Bobby',
        street_address: '123 fake st.',
        city: 'Fakertown',
        state: 'CO',
        zip: '80205'
      })

      user_2 = User.create({
        name: "Sarah",
        street_address: '444 Lonely Ln.',
        city: 'Seattle',
        state: 'WA',
        zip: '90256'
        })

      application_1 = Application.create(
        user_id: "#{user_1.id}",
        application_status: 'In Progress',
      )

      application_2 = Application.create(
        user_id: "#{user_2.id}",
        application_status: 'In Progress',
      )

      pet_1 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Lizzie",
        description: "Timid and affectionate once she knows you.",
        age: 6,
        sex: "female",
        shelter_id: "#{shelter_1.id}",
        adoptable: true
      })

      pet_2 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Guiness",
        description: "Floppy-eared dude ready to play ball!",
        age: 3,
        sex: "male",
        shelter_id: "#{shelter_1.id}"
      })
      pet_3 = Pet.create({
        image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
        name: "Nena",
        description: "In your face and always hungry.",
        age: 9,
        sex: "female",
        shelter_id: "#{shelter_1.id}"
      })

      pet_4 = Pet.create({
        image: "https://www.guidedogs.org/wp-content/uploads/2019/11/website-donate-mobile.jpg",
        name: "Gus",
        description: "Always sittin' pretty.",
        age: 4,
        sex: "male",
        shelter_id: "#{shelter_2.id}"
        })


      petapp_1 = PetApplication.create!(
        application_id: "#{application_1.id}",
        pet_id: "#{pet_1.id}",
        approval: "Pending"
      )

      petapp_2 = PetApplication.create!(
        application_id: "#{application_1.id}",
        pet_id: "#{pet_2.id}",
        approval: "Pending"
      )

      petapp_3 = PetApplication.create!(
        application_id: "#{application_1.id}",
        pet_id: "#{pet_3.id}",
        approval: "Pending"
      )

      petapp_4 = PetApplication.create!({
        application_id: "#{application_2.id}",
        pet_id: "#{pet_4.id}",
        approval: "Pending"
        })

      visit "/admin/applications/#{application_1.id}"

      expect(page).to have_button("Approve Pet", count: 3)
      click_button("Approve Pet", match: :first)

      expect(page).to have_content("Pet Approved")
      expect(page).to have_button("Approve Pet", count: 2)
    end
  end
end