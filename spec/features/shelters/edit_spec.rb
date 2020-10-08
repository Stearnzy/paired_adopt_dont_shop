require 'rails_helper'

describe "As a user" do
  describe "I am taken to '/shelters/:id/edit'" do
    it "where I see a form to edit the shelter's data" do
    shelter = Shelter.create({
      name: "Crazy Cat Lady's",
      address: "123 Litterbox Way",
      city: "Littleton",
      state: "CO",
      zip: "80123"
      })

    visit "/shelters/#{shelter.id}"

    click_link "Update Shelter"
    expect(current_path).to eq("/shelters/#{shelter.id}/edit")

    expect(page).to have_content("Edit shelter:")
    expect(find_field('shelter[name]').value).to eq("Crazy Cat Lady's")
    expect(find_field('shelter[address]').value).to eq("123 Litterbox Way")
    expect(find_field('shelter[city]').value).to eq("Littleton")
    expect(find_field('shelter[state]').value).to eq("CO")
    expect(find_field('shelter[zip]').value).to eq("80123")

    fill_in "shelter[city]", with: "Denver"
    expect(find_field('shelter[city]').value).to eq('Denver')

    click_button('submit')
    expect(current_path).to eq("/shelters/#{shelter.id}")
    end
  end
end