require 'rails_helper'

describe "As a visitor" do
  describe "when I visit a User's show page" do
    before(:each) do
      @user = User.create({
        name: 'Bobby',
        street_address: '123 fake st.',
        city: 'Fakertown',
        state: 'CO',
        zip: '80205'
      })
    end

    it "I see all that User's information" do
      visit "/users/#{@user.id}"

      expect(page).to have_content("#{@user.name}")
      expect(page).to have_content("#{@user.street_address}")
      expect(page).to have_content("#{@user.city}")
      expect(page).to have_content("#{@user.state}")
      expect(page).to have_content("#{@user.zip}")
    end
  end
end
