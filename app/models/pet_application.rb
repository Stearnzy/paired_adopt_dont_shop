class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates_presence_of :approval

  def retrieve_name
    Pet.find(self.pet_id).name
  end

  def retrieve_user
    User.find(self.user_id)
  end

  def self.pet_approved?
    approval == "Approved"
  end
end
