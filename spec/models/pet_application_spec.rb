require "rails_helper"

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should belong_to :pet}
    it { should belong_to :application}
    it { should validate_presence_of :approval }
  end

  it "retrieve pet name from PetApplication" do
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

    expect(petapp_1.retrieve_pet_name).to eq("Lizzie")
  end

end