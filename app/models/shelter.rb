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
    apps_per_shelter.any?{ |app| app.application_status == "Pending" }
<<<<<<< HEAD
  end

  def all_pets_adoptable?
    self.pets.all?{ |pet| pet.adoptable == true }
=======
>>>>>>> e3986a935dbe1370d7d39244fc17e3cce731823a
  end

  def apps_per_shelter
    shelter_pets = Pet.where(shelter_id: self.id)
    apps_per_shelter = shelter_pets.map {|pet| pet.applications}
    apps_per_shelter.flatten
  end
end