describe "Then I see a link to add a new adoptable pet for the shelter 'Create Pet'" do
  it "When I click the link I am taken to a new page where there is a form to
      add a new adoptable pet; enter image, name, description, age, sex and click
      create pet.  Pet is posted to that shelter" do

        visit "/shelters/#{@shelter_1.id}/pets"

        click_link("Create Pet")
        expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")


        fill_in "name", with: "Opus"
        fill_in "description", with: "He's a quiet guy."
        fill_in "age", with: 7
        choose('Male')
        click_button 'Create Pet'

        expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
        expect(page).to have_xpath
        expect(page).to have_content("#{@shelter_1.name}: Pets")
        expect(page).to have_content("Opus")
        expect(page).to have_content("He's a quiet guy.")
        expect(page).to have_content(7)
        expect(find_field("Sex")).to be_checked
  end
end
