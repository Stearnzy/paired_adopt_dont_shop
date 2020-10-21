require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it { should have_many(:pets).dependent(:destroy) }
    it { should have_many(:reviews).dependent(:destroy) }
  end

  it 'can count the pets in a shelter' do

    shelter_1 = Shelter.create({
      name: "Crazy Cat Lady's",
      address: "123 Litterbox Way",
      city: "Littleton",
      state: "CO",
      zip: "80110"
    })

    pet_1 = Pet.create({
      image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
      name: "Lizzie",
      description: "Timid and affectionate once she knows you.",
      age: 6,
      sex: "female",
      shelter_id: "#{shelter_1.id}",
      adoptable: true
    })

    pet_2 = Pet.create({
      image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
      name: "Nena",
      description: "Tons of energy and always hungry.",
      age: 10,
      sex: "female",
      shelter_id: "#{shelter_1.id}",
      adoptable: true
    })

    expect(shelter_1.pet_count).to eq(2)
  end

  it 'knows the average of the reviews for that shelter' do  

    shelter_1 = Shelter.create({
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
      shelter_id: "#{shelter_1.id}",
      user_id: "#{user.id}"
    })

    review_3 = Review.create!({
      user_name: "Bobby",
      title: "Bird crap everywhere",
      rating: 1,
      content: "Worst ever.",
      shelter_id: "#{shelter_1.id}",
      user_id: "#{user.id}"
    })

    expect(shelter_1.review_average.round(2)).to  eq(2.67)
  end 

  it 'can count the number of applications per shelter' do
    shelter_1 = Shelter.create({
      name: "Crazy Cat Lady's",
      address: "123 Litterbox Way",
      city: "Littleton",
      state: "CO",
      zip: "80110"
    })

    pet_1 = Pet.create({
      image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
      name: "Lizzie",
      description: "Timid and affectionate once she knows you.",
      age: 6,
      sex: "female",
      shelter_id: "#{shelter_1.id}",
      adoptable: true
    })

    user_1 = User.create({
      name: 'Bobby',
      street_address: '123 fake st.',
      city: 'Fakertown',
      state: 'CO',
      zip: '80205'
    })

    application_1 = Application.create(
      user_id: "#{user_1.id}",
      application_status: 'In Progress',
    )

    application_2 = Application.create(
      user_id: "#{user_1.id}",
      application_status: 'In Progress',
    )

    petapp_1 = PetApplication.create!(
      application_id: "#{application_1.id}",
      pet_id: "#{pet_1.id}",
      approval: "Pending"
    )

    petapp_2 = PetApplication.create!(
      application_id: "#{application_2.id}",
      pet_id: "#{pet_1.id}",
      approval: "Pending"
    )

    expect(shelter_1.application_count).to eq(2)
  
  end
end