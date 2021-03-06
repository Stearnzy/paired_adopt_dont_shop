require 'rails_helper'

describe "When I am taken to '/shelters/new'" do
  it "I see a form for a new shelter" do
    visit "/shelters/new"

    fill_in "Shelter Name", with: "Rabbit Room"
    fill_in "Address", with: "555 Fluffytail Lane"
    fill_in "City", with: "Longmont"
    fill_in "State", with: "CO"
    fill_in "Zip", with: "80565"

    click_button("Create Shelter")
  end

  it "To see links to pets index and shelter index" do
    visit "/shelters/new"

    expect(page).to have_link("To Pets Index")
    expect(page).to have_link("To Shelters Index")
  end
end

