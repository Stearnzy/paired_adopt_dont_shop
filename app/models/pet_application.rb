class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates_presence_of :approval

  def retrieve_pet
    Pet.find(self.pet_id)
  end
  
  def retrieve_pet_name
    retrieve_pet.name
  end

  def pet_adoptable?
    retrieve_pet.adoptable
  end
end
