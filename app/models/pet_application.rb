class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates_presence_of :approval

  # def self.pet_approval?
  #   if approval = 
  #   approval == "Approved"
  # end
end 