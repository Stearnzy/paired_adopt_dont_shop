class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications
  validates_presence_of :image, :name, :description, :age, :sex, :adoptable

  def any_approved_applications?
    applications.any?{|app| app.application_status == "Approved"}
  end
end