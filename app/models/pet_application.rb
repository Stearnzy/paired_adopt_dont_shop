class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates_presence_of :approval

  def retrieve_pet
    Pet.find(self.pet_id)
  end

  # def retrieve_user
  #   User.find(self.user_id)
  # end

  # def self.pet_approved?
  #   approval == "Approved"
  # end 
  
  def retrieve_pet_name
    retrieve_pet.name
  end

  def pet_adoptable?
    retrieve_pet.adoptable
  end
end
