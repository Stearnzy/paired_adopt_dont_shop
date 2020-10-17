require 'rails_helper'

describe "As a user" do
  describe "When I click on a review edit link" do
    xit "I am taken to an edit shelter review page where I see a form that includes
    that review's pre populated title, rating, content, image, and user name" do
    shelter = Shelter.create({
      name: "Crazy Cat Lady's",
      address: "123 Litterbox Way",
      city: "Littleton",
      state: "CO",
      zip: "80110"
      })

    user = User.create({
      name: 'Bobby',
      street_address: '123 fake st.',
      city: 'Fakertown',
      state: 'CO',
      zip: '80205'
    })

    review = Review.create!({
      title: "Great Place!",
      rating: 4,
      content: "Friendly staff, clean establishment",
      user_name: "Karen",
      picture: "https://face4pets.org/wp-content/uploads/2015/06/shelter-cat2.jpg",
      shelter_id: "#{shelter.id}",
      user_id: "#{user.id}"
    })

    visit "/shelters/#{shelter.id}/review/#{review.id}/edit"

    expect(page).to have_content("Edit Review:")
    expect(find_field('title').value).to eq("#{review.title}")
    expect(find_field('rating').value).to eq("#{review.rating}")
    expect(find_field('content').value).to eq("#{review.content}")
    expect(find_field('user_name').value).to eq("#{review.user_name}")
    expect(find_field('picture').value).to eq("#{review.picture}")

    fill_in "rating", with: 5
    expect(find_field("rating").value).to eq("5")

    click_button('Submit')
    expect(current_path).to eq("/shelters/#{shelter.id}")

      within "#name-review" do
        expect(page).to have_content("5")
      end
    end

    describe "When I visit the page to edit a review" do
      xit "And I fail to enter a title, a rating, and/or content in the edit 
      shelter review form, but still try to submit the form
      I see a flash message indicating that I need to fill in a title, 
      rating, and content in order to edit a shelter review
      And I'm returned to the edit form to edit that review" do

      shelter = Shelter.create({
        name: "Crazy Cat Lady's",
        address: "123 Litterbox Way",
        city: "Littleton",
        state: "CO",
        zip: "80110"
      })

      user = User.create({
        name: 'Bobby',
        street_address: '123 fake st.',
        city: 'Fakertown',
        state: 'CO',
        zip: '80205'
      })

      review = Review.create!({
        title: "Great Place!",
        rating: 4,
        content: "Friendly staff, clean establishment",
        user_name: "Karen",
        picture: "https://face4pets.org/wp-content/uploads/2015/06/shelter-cat2.jpg",
        shelter_id: "#{shelter.id}",
        user_id: "#{user.id}"
      })

      visit "/shelters/#{shelter.id}/review/#{review.id}/edit"

      expect(find_field('title').value).to eq("Great Place!")
      fill_in 'title', with: ""
      
      click_button('Submit')
      
      expect(page).to have_content("Please fill in title, rating, and content before submitting.")  
      expect(page).to have_button('Submit')
      end

      it "I enter the name of a User that doesn't exist in the database, 
      but still try to submit the form I see a flash message indicating 
      that the User couldn't be found
      And I'm returned to the new form to create a new review" do

      shelter = Shelter.create!({
        name: "Crazy Cat Lady's",
        address: "123 Litterbox Way",
        city: "Littleton",
        state: "CO",
        zip: "80110"
      })

      user = User.create!({
        name: 'Bobby',
        street_address: '123 fake st.',
        city: 'Fakertown',
        state: 'CO',
        zip: '80205'
      })

      review = Review.create!({
        title: "Great Place!",
        rating: 4,
        content: "Friendly staff, clean establishment",
        user_name: "Bobby",
        picture: "https://face4pets.org/wp-content/uploads/2015/06/shelter-cat2.jpg",
        shelter_id: "#{shelter.id}",
        user_id: "#{user.id}"
      })
        # require 'pry'; binding.pry
      visit "/shelters/#{shelter.id}/review/#{review.id}/edit"

      fill_in 'user_name', with: "Todd"

      click_button('Submit')
      
      expect(page).to have_content("Please fill in a valid user name.")  
      expect(page).to have_button('Submit')
      end
    end  
  end
end