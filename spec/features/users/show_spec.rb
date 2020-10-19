require 'rails_helper'

describe "As a visitor" do
  describe "when I visit a User's show page" do
    before(:each) do
      @user_1 = User.create({
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
        user_name: "#{@user_1.name}",
        title: "Love this place",
        rating: 5,
        content: "Great staff all around",
        shelter_id: "#{@shelter_1.id}",
        user_id: "#{@user_1.id}"
        })

      @review_2 = Review.create!({
        user_name: "#{@user_1.name}",
        title: "Dogs are OK",
        rating: 2,
        content: "One peed on my leg",
        shelter_id: "#{@shelter_2.id}",
        user_id: "#{@user_1.id}"
        })

      @review_3 = Review.create!({
        user_name: "#{@user_1.name}",
        title: "Bird crap everywhere",
        rating: 1,
        content: "Worst ever.",
        shelter_id: "#{@shelter_3.id}",
        user_id: "#{@user_1.id}"
        })
    end

    it "I see all that User's information" do
      visit "/users/#{@user_1.id}"

      expect(page).to have_content("#{@user_1.name}")
      expect(page).to have_content("#{@user_1.street_address}")
      expect(page).to have_content("#{@user_1.city}")
      expect(page).to have_content("#{@user_1.state}")
      expect(page).to have_content("#{@user_1.zip}")
    end

    it "I see the average rating of all of their reviews" do
      visit "/users/#{@user_1.id}"

      expect(page).to have_content("Average User Rating: #{@user_1.review_average.round(2)}")
    end

    describe "I see a section for Highlighted Reviews" do
      it "And I see the review with the best rating this user has written, and
        I see the review with the worst rating this user has written" do
        visit "/users/#{@user_1.id}"

        within "#highlighted" do
          expect(page).to have_content("Highlighted User Reviews")
        end

        within "#best-review" do
          expect(page).to have_content("#{@review_1.title}")
          expect(page).to have_content("#{@review_1.rating}")
          expect(page).to have_content("#{@review_1.content}")
        end

        within "#worst-review" do
          expect(page).to have_content("#{@review_3.title}")
          expect(page).to have_content("#{@review_3.rating}")
          expect(page).to have_content("#{@review_3.content}")
        end
      end
    end

    it "I do not see any highlighted reviews if user has less than two reviews" do

      thomas = User.create({
        name: 'Thomas',
        street_address: "666 Lover's lane",
        city: 'Little Paris',
        state: 'NY',
        zip: "96015"
        })

      review_4 = Review.create!({
        user_name: "#{thomas.name}",
        title: "Too much hair around",
        rating: 2,
        content: "Want to like it, but there's a lot",
        shelter_id: "#{@shelter_2.id}",
        user_id: "#{thomas.id}"
        })

      visit "/users/#{thomas.id}"

      expect(page).to_not have_content("Highlighted User Reviews")
      expect(page).to_not have_content("Best Review")
      expect(page).to_not have_content("Worst Review")
    end
  end
end
