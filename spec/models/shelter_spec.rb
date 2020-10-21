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

  
end