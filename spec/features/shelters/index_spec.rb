require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/shelters'" do
    before(:each) do
      @shelter_1 = Shelter.create({
            name: "Crazy Cat Lady's",
            address: "123 Litterbox Way",
            city: "Littleton",
            state: "CO",
            zip: "80110"
        })
      @shelter_2 = Shelter.create({
            name: "Perky Parakeets",
            address: "333 S Tropicana St.",
            city: "Las Vegas",
            state: "NV",
            zip: "66666"
        })

      @user = User.create({
        name: 'Bobby',
        street_address: '123 fake st.',
        city: 'Fakertown',
        state: 'CO',
        zip: '80205'
      })

      @pet_1 = Pet.create({
        image: "https://g5f3c5t9.rocketcdn.me/wp-content/uploads/2020/04/edited-vet-recommended-parakeet-sleeping-huts-1-of-1.jpg",
        name: "Polly",
        description: "She loves crackers",
        age: 9,
        sex: "Female",
        shelter_id: "#{@shelter_2.id}"
        })

      @pet_2 = Pet.create({
        image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.ktvb.com%2Farticle%2Fentertainment%2Fplaces%2Fidaho-life%2Fidaho-life-boise-woman-finds-niche-as-pho-dog-grapher%2F277-d6456b15-6b2a-4bad-9b25-eeb58faf1323&psig=AOvVaw3hm5tZEVkZl17MKIwo9X_I&ust=1603338603299000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODUzvHjxOwCFQAAAAAdAAAAABAD",
        name: "Nena",
        description: "She is always ready to share some of your food!",
        age: 10,
        sex: "female",
        shelter_id: "#{@shelter_1.id}"
      })

      @pet_3 = Pet.create({
        image: 'https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg',
        name: "Garfield",
        description: "Ready and willing to eat your lasagna.",
        age: 13,
        sex: "male",
        shelter_id: "#{@shelter_1.id}"
        })

      @application_1 = Application.create!({
        user_id: @user.id,
        description: nil,
        application_status: "Pending"
        })

      @petapp_2 = PetApplication.create!(
        application_id: "#{@application_1.id}",
        pet_id: "#{@pet_2.id}",
        approval: "Approved"
      )

      @petapp_3 = PetApplication.create!(
        application_id: "#{@application_1.id}",
        pet_id: "#{@pet_3.id}",
        approval: "Pending"
      )
    end

    it "then I see the name of each shelter in the system" do
      visit '/shelters'

      expect(page).to have_content("Our Family of Shelters")
      expect(page).to have_content("#{@shelter_1.name}")
      expect(page).to have_content("#{@shelter_2.name}")
    end

    it "I see a link to create a new shelter" do
      visit '/shelters'

      expect(page).to have_link("New Shelter")
    end

    it "Next to every shelter I see a link to edit that shelter's info.  When I
        click the link I should be taken to that shelter's edit page" do
      visit '/shelters'

      expect(page).to have_link("Edit Shelter", count: 2)
      find(:xpath, "(//a[text()='Edit Shelter'])[2]").click
      expect(current_path).to eq("/shelters/#{@shelter_2.id}/edit")
    end

    it "Next to every shelter I see a link to delete that shelter.  When I click
        the link, I am returned to the Shelter Index Page" do
      visit '/shelters'

      expect(page).to have_link("Delete Shelter", count: 2)
      find(:xpath, "(//a[text()='Delete Shelter'])[2]").click
      expect(page).to_not have_content("#{@shelter_2.name}")
    end

    it "When I click on the name a shelter anywhere on the site
      Then that link takes me to that Shelter's show page" do
      visit "/shelters"

      expect(page).to have_link("#{@shelter_1.name}")
      expect(page).to have_link("#{@shelter_2.name}")
      click_link("#{@shelter_1.name}")
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    end

    it "To see links to pets index and shelter index" do
      visit "/shelters"

      expect(page).to have_link("To Pets Index")
    end

    it "If a shelter has approved applications for any of their pets I cannot
        delete that shelter" do
      visit "/shelters"

      within "#shelter-#{@shelter_1.id}" do
        click_link "Delete Shelter"
      end

      expect(page).to have_content("Cannot delete shelter with pending applications!")
    end

    it "If a shelter doesn't have any pets with an approved application I can delete
        that shelter. When that shelter is deleted, all their pets are also deleted" do
      visit "/shelters"

      within "#shelter-#{@shelter_2.id}" do
        click_link "Delete Shelter"
      end

      expect(page).to_not have_content("#{@shelter_2.name}")
      click_link "To Pets Index"
      expect(page).to_not have_content("#{@pet_1.name}")
    end
  end
end