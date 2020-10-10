require 'rails_helper'

describe "Then I see a link to add a new adoptable pet for the shelter 'Create Pet'" do
  it "When I click the link I am taken to a new page where there is a form to
      add a new adoptable pet; enter image, name, description, age, sex and click
      create pet.  Pet is posted to that shelter" do

        @shelter = Shelter.create({
          name: "Crazy Cat Lady's",
          address: "123 Litterbox Way",
          city: "Littleton",
          state: "CO",
          zip: "80110"
          })

        visit "/shelters/#{@shelter.id}/pets"

        click_link("Create Pet")
        expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")

        # attach_file("image", "https://frontpagemeews.com/wp-content/uploads/2018/12/lazy-cat-cover-750x517.png")
        fill_in "image", with: "https://frontpagemeews.com/wp-content/uploads/2018/12/lazy-cat-cover-750x517.png"
        fill_in "name", with: "Opus"
        fill_in "description", with: "He's a quiet guy."
        fill_in "age", with: 7
        choose(:sex, option: "Male")

        click_button 'Create Pet'

        expect(current_path).to eq("/shelters/#{@shelter.id}/pets")
        expect(page).to have_content("Create New Pet:")
        expect(page).to have_xpath("//img[contains(@src, 'https://frontpagemeews.com/wp-content/uploads/2018/12/lazy-cat-cover-750x517.png')]")
        expect(page).to have_content("#{@shelter.name}: Pets")
        expect(page).to have_content("Opus")
        expect(page).to have_content("He's a quiet guy.")
        expect(page).to have_content(7)
        expect(find_field("Sex")).to be_checked
  end
end
