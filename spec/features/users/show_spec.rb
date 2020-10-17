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

      @shelter_1 = Shelter.create({
        name: "Crazy Cat Lady's",
        address: "123 Litterbox Way",
        city: "Littleton",
        state: "CO",
        zip: "80110"
        })

      @shelter_2 = Shelter.create({
        name: "Danny's Dogs",
        address: "123 Bark Rd",
        city: "Littleton",
        state: "CO",
        zip: "80110"
        })

      @shelter_3 = Shelter.create({
        name: "Perky Parakeets",
        address: "123 Tropicana St",
        city: "Littleton",
        state: "CO",
        zip: "80110"
        })

      @review_1 = Review.create!({
        user_name: "Bobby",
        title: "Love this place",
        rating: 5,
        content: "Great staff all around",
        shelter_id: "#{@shelter_1.id}",
        user_id: "#{@user.id}"
        })

      @review_2 = Review.create!({
        user_name: "Bobby",
        title: "Dogs are OK",
        rating: 2,
        content: "One peed on my leg",
        shelter_id: "#{@shelter_2.id}",
        user_id: "#{@user.id}"
        })

      @review_3 = Review.create!({
        user_name: "Bobby",
        title: "Bird crap everywhere",
        rating: 1,
        content: "Worst ever.",
        shelter_id: "#{@shelter_3.id}",
        user_id: "#{@user.id}"
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

    xit "I see the average rating of all of their reviews" do
      visit "/users/#{@user.id}"

      expect(page).to have_content("Average User Rating: #{@user.review_average.round(2)}")
    end

    describe "I see a section for Highlighted Reviews" do
      it "And I see the review with the best rating this user has written, and
        I see the review with the worst rating this user has written" do
        visit "/users/#{@user.id}"

        within "#highlighted" do
          expect(page).to have_content("Highlighted User Reviews")

          expect(page).to have_content("#{@review_1}.title")
          expect(page).to have_content("#{@review_1}.rating")
          expect(page).to have_content("#{@review_1}.content")

          expect(page).to have_content("#{@review_3}.title")
          expect(page).to have_content("#{@review_3}.rating")
          expect(page).to have_content("#{@review_3}.content")
        end
      end
    end
  end
end
