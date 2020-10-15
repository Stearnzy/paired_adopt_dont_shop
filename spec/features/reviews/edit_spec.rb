describe "As a user" do
  describe "When I click on a review edit link" do
    it "I am taken to an edit shelter review page where I see a form that includes
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
      user_name: "Cat Lady",
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
    end
  end
end