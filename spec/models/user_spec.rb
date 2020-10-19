require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it { should have_many(:reviews) }
  end

  it "calculate average rating of all reviews" do
    user = User.create({
      name: 'Bobby',
      street_address: '123 fake st.',
      city: 'Fakertown',
      state: 'CO',
      zip: '80205'
    })

    shelter_1 = Shelter.create({
      name: "Crazy Cat Lady's",
      address: "123 Litterbox Way",
      city: "Littleton",
      state: "CO",
      zip: "80110"
      })

    shelter_2 = Shelter.create({
      name: "Danny's Dogs",
      address: "123 Bark Rd",
      city: "Littleton",
      state: "CO",
      zip: "80110"
      })

    shelter_3 = Shelter.create({
      name: "Perky Parakeets",
      address: "123 Tropicana St",
      city: "Littleton",
      state: "CO",
      zip: "80110"
      })

    review_1 = Review.create!({
      user_name: "Bobby",
      title: "Love this place",
      rating: 5,
      content: "Great staff all around",
      shelter_id: "#{shelter_1.id}",
      user_id: "#{user.id}"
      })

    review_2 = Review.create!({
      user_name: "Bobby",
      title: "Dogs are OK",
      rating: 2,
      content: "One peed on my leg",
      shelter_id: "#{shelter_2.id}",
      user_id: "#{user.id}"
      })

    review_3 = Review.create!({
      user_name: "Bobby",
      title: "Bird crap everywhere",
      rating: 1,
      content: "Worst ever.",
      shelter_id: "#{shelter_3.id}",
      user_id: "#{user.id}"
      })

    expect(user.review_average.round(2)).to eq(2.67)
  end

  it "I see the review with the best rating that this user has written" do
    user = User.create({
      name: 'Bobby',
      street_address: '123 fake st.',
      city: 'Fakertown',
      state: 'CO',
      zip: '80205'
    })

    shelter_1 = Shelter.create({
      name: "Crazy Cat Lady's",
      address: "123 Litterbox Way",
      city: "Littleton",
      state: "CO",
      zip: "80110"
      })

    shelter_2 = Shelter.create({
      name: "Danny's Dogs",
      address: "123 Bark Rd",
      city: "Littleton",
      state: "CO",
      zip: "80110"
      })

    shelter_3 = Shelter.create({
      name: "Perky Parakeets",
      address: "123 Tropicana St",
      city: "Littleton",
      state: "CO",
      zip: "80110"
      })

    review_1 = Review.create!({
      user_name: "Bobby",
      title: "Love this place",
      rating: 5,
      content: "Great staff all around",
      shelter_id: "#{shelter_1.id}",
      user_id: "#{user.id}"
      })

    review_2 = Review.create!({
      user_name: "Bobby",
      title: "Dogs are OK",
      rating: 2,
      content: "One peed on my leg",
      shelter_id: "#{shelter_2.id}",
      user_id: "#{user.id}"
      })

    review_3 = Review.create!({
      user_name: "Bobby",
      title: "Bird crap everywhere",
      rating: 1,
      content: "Worst ever.",
      shelter_id: "#{shelter_3.id}",
      user_id: "#{user.id}"
      })

    expect(user.best_review).to eq(review_1)
  end

  it "I see the review with the worst rating that this user has written" do
    user = User.create({
      name: 'Bobby',
      street_address: '123 fake st.',
      city: 'Fakertown',
      state: 'CO',
      zip: '80205'
    })

    shelter_1 = Shelter.create({
      name: "Crazy Cat Lady's",
      address: "123 Litterbox Way",
      city: "Littleton",
      state: "CO",
      zip: "80110"
      })

    shelter_2 = Shelter.create({
      name: "Danny's Dogs",
      address: "123 Bark Rd",
      city: "Littleton",
      state: "CO",
      zip: "80110"
      })

    shelter_3 = Shelter.create({
      name: "Perky Parakeets",
      address: "123 Tropicana St",
      city: "Littleton",
      state: "CO",
      zip: "80110"
      })

    review_1 = Review.create!({
      user_name: "Bobby",
      title: "Love this place",
      rating: 5,
      content: "Great staff all around",
      shelter_id: "#{shelter_1.id}",
      user_id: "#{user.id}"
      })

    review_2 = Review.create!({
      user_name: "Bobby",
      title: "Dogs are OK",
      rating: 2,
      content: "One peed on my leg",
      shelter_id: "#{shelter_2.id}",
      user_id: "#{user.id}"
      })

    review_3 = Review.create!({
      user_name: "Bobby",
      title: "Bird crap everywhere",
      rating: 1,
      content: "Worst ever.",
      shelter_id: "#{shelter_3.id}",
      user_id: "#{user.id}"
      })

    expect(user.worst_review).to eq(review_3)
  end
end