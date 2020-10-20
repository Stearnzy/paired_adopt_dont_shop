class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates_presence_of :approval

<<<<<<< HEAD
  # def self.pet_approval?
  #   if approval = 
  #   approval == "Approved"
  # end
end 
=======
  def retrieve_name
    Pet.find(self.pet_id).name
  end

  def self.pet_approved?
    approval == "Approved"
  end
end
>>>>>>> 68c4a8279f2ed8cfd49f348e770a4326555244e2
