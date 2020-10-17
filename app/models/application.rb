class Application < ApplicationRecord
  # validates_presence_of :description
  validates_presence_of :application_status
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications
end