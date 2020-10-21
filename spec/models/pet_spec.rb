require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :image }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :age }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :adoptable }
  end

  describe "relationships" do
    it { should belong_to :shelter }
    it { should have_many :pet_applications }
    it { should have_many(:applications).through(:pet_applications) }
  end

  it "knows approved applications" do
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

    pet_2 = Pet.create({
      image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074__340.jpg",
      name: "Nena",
      description: "Cute, loving, and always hungry.",
      age: 10,
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

    application_2 = Application.create(
      user_id: "#{user_1.id}",
      application_status: 'Approved',
    )

    petapp_1 = PetApplication.create!(
      application_id: "#{application_2.id}",
      pet_id: "#{pet_2.id}",
      approval: "Pending"
    )

    expect(pet_1.any_approved_applications?).to eq(false)
    expect(pet_2.any_approved_applications?).to eq(true)
  end 
end