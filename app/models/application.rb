class Application < ApplicationRecord
  validates_presence_of :application_status
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def pet_ids
    self.pets.map {|pet| pet.id}
  end

  def find_pet_apps
    PetApplication.where(pet_id: self.pet_ids)
  end
end