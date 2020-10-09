require 'rails_helper'

# As a visitor
# When I visit '/shelters/:shelter_id/pets'
# Then I see each Pet that can be adopted from that Shelter with that shelter_id including the Pet's:
# - image
# - name
# - approximate age
# - sex

describe "As a visitor" do
  describe "When I visit '/shelters/:shelter_id/pets'" do
    it "then I see each Pet that can be adopted from that shelter with that shelter_id
        including the pet's image, name, appoximate age, and sex" do

        shelter = Shelter.create({
              name: "Crazy Cat Lady's",
              address: "123 Litterbox Way",
              city: "Littleton",
              state: "CO",
              zip: "80110"
          })

        pet_1 = Pet.create({
          image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg",
          name: "Garfield",
          age: 5,
          sex: "male",
          shelter: "Crazy Cat Lady's"
          })

        pet_2 = Pet.create({
          image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
          name: "Guiness",
          age: 3,
          sex: "male",
          shelter: "Dog's Haven"
          })


      visit "/shelters/#{shelter.id}/pets"

      expect(page).to have_content("#{shelter.name}: Pets")
      expect(page).to have_xpath("//img[contains(@src, '#{pet_1.image}')]")
      expect(page).to have_content("#{pet_1.name}")
      # May need to change this, integer
      expect(page).to have_content(pet_1.age)
      expect(page).to have_content("#{pet_1.sex}")

      expect(page).to have_link("Return to #{shelter.name}")
      expect(page).to have_link("Return to Shelters Home")
    end
  end
end