class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates_presence_of :approval

  def retrieve_name
    Pet.find(self.pet_id).name
  end
end
