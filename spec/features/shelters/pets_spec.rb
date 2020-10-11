require 'rails_helper'

describe "As a visitor" do
  describe "When I visit '/shelters/:shelter_id/pets'" do
    before(:each) do
      @shelter_1 = Shelter.create({
            name: "Crazy Cat Lady's",
            address: "123 Litterbox Way",
            city: "Littleton",
            state: "CO",
            zip: "80110"
        })

      @pet_1 = Pet.create({
        image: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg",
        name: "Garfield",
        description: "Fat happy cat wants some lasagna.",
        age: 5,
        sex: "Male",
        shelter_id: "#{@shelter_1.id}"
        })

      @pet_2 = Pet.create({
        image: "https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
        name: "Toby",
        description: "Skittish, yet fun.",
        age: 2,
        sex: "Male",
        shelter_id: "#{@shelter_1.id}"
        })
    end

    it "then I see each Pet that can be adopted from that shelter with that shelter_id
        including the pet's image, name, appoximate age, and sex" do

      visit "/shelters/#{@shelter_1.id}/pets"

      expect(page).to have_content("#{@shelter_1.name}: Pet")
      expect(page).to have_xpath("//img[contains(@src, '#{@pet_1.image}')]")
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_content(@pet_1.age)
      expect(page).to have_content("#{@pet_1.sex}")

      expect(page).to have_link("Create Pet")
    end

    it "Next to every pet I see a link to edit that pet's info.  When I click
        the link I should be taken to that pets edit page" do
      visit "/shelters/#{@shelter_1.id}/pets"

      expect(page).to have_link("Edit Pet Info", count: 2)
      find(:xpath, "(//a[text()='Edit Pet Info'])[2]").click
      expect(current_path).to eq("/pets/#{@pet_2.id}/edit")
    end

    it "Next to every pet, I see a link to delete that pet. Clicking it takes
        me to the pets index page where I no longer see that pet" do
      visit "/shelters/#{@shelter_1.id}/pets"

      expect(page).to have_link("Delete Pet", count: 2)
      find(:xpath, "(//a[text()='Delete Pet'])[2]").click
      expect(page).to_not have_content("#{@pet_2}.image")
      expect(page).to_not have_content("#{@pet_2}.name")
      expect(page).to_not have_content("#{@pet_2}.age")
      expect(page).to_not have_content("#{@pet_2}.sex")
    end

  end
end