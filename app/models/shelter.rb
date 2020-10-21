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
    apps_per_shelter.count
  end

  def any_pending_applications?
    apps_per_shelter.flatten.any?{ |app| app.application_status == "Pending" }
  end

  def apps_per_shelter
    shelter_pets = Pet.where(shelter_id: self.id)
    apps_per_shelter = shelter_pets.map {|pet| pet.applications}
  end
end