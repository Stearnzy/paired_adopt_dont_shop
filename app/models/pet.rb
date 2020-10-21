class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications
  validates_presence_of :image, :name, :description, :age, :sex, :adoptable

  # def toggle_adopt
  #   self.adoptable = false
  # end

  def any_approved_applications?
    self.applications.any?{|app| app.application_status == "Approved"}
  end

  # def apps_per_pet
  #   Application.find_by(params[:id])
  # end
end