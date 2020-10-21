require 'rails_helper'

describe Application, type: :model do
  describe "validations" do
    it { should validate_presence_of :application_status}
  end

  describe "relationships" do
    it { should belong_to :user }
    it { should have_many(:pets).through(:pet_applications) }
  end

  it "can find all pet applications" do
    shelter_1 = Shelter.create({
      name: "Crazy Cat Lady's",
      address: "123 Litterbox Way",
      city: "Littleton",
      state: "CO",
      zip: "80110"
    })

    user_1 = User.create({
      name: 'Bobby',
      street_address: '123 fake st.',
      city: 'Fakertown',
      state: 'CO',
      zip: '80205'
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

    application_1 = Application.create(
      user_id: "#{user_1.id}",
      application_status: 'In Progress',
    )

    petapp_1 = PetApplication.create!(
      application_id: "#{application_1.id}",
      pet_id: "#{pet_1.id}",
      approval: "Pending"
    )

    expect(application_1.find_pet_apps).to eq([petapp_1])
  end

  it "can retrieve the user" do
    shelter_1 = Shelter.create({
      name: "Crazy Cat Lady's",
      address: "123 Litterbox Way",
      city: "Littleton",
      state: "CO",
      zip: "80110"
    })

    user_1 = User.create({
      name: 'Bobby',
      street_address: '123 fake st.',
      city: 'Fakertown',
      state: 'CO',
      zip: '80205'
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

    application_1 = Application.create(
      user_id: "#{user_1.id}",
      application_status: 'In Progress',
    )

    petapp_1 = PetApplication.create!(
      application_id: "#{application_1.id}",
      pet_id: "#{pet_1.id}",
      approval: "Pending"
    )

    expect(application_1.retrieve_user).to eq(user_1)
  end

  xit "knows if all pet applications are approved" do
    shelter_1 = Shelter.create({
      name: "Crazy Cat Lady's",
      address: "123 Litterbox Way",
      city: "Littleton",
      state: "CO",
      zip: "80110"
    })

    user_1 = User.create({
      name: 'Bobby',
      street_address: '123 fake st.',
      city: 'Fakertown',
      state: 'CO',
      zip: '80205'
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

    application_1 = Application.create(
      user_id: "#{user_1.id}",
      application_status: 'In Progress',
    )

    petapp_1 = PetApplication.create!(
      application_id: "#{application_1.id}",
      pet_id: "#{pet_1.id}",
      approval: "Pending"
    )

    expect(application_1.all_approved?).to eq(true)
  end
end