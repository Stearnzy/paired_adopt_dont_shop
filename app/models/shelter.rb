class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def pet_count
    pets.count
  end

  def review_average
    reviews.average(:rating)
  end

  def application_count
    shelter_pets = Pet.where(shelter_id: self.id)
    apps_per_pet = shelter_pets.map {|pet| pet.applications.count}
    apps_per_pet.sum
  end

end