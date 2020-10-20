class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  validates_presence_of :image, :name, :description, :age, :sex, :adoptable

  def method_name

  end
end