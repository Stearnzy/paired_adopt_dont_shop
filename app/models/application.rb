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

   def retrieve_user
    User.find(self.user_id)
  end

  def approve_or_reject
    # require 'pry'; binding.pry
    if pet_applications.where.not(approval: "Approved").empty?
      application_status = "Approved"
      pets.each do |pet|
        pet.toggle!(:adoptable)
      end
    elsif pet_applications.where(approval: "Rejected").any?
      application_status = "Rejected"
    end
  end

end