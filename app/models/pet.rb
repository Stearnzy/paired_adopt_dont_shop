class Pet < ApplicationRecord
  belongs_to :shelter
  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :sex
  validates_presence_of :current_shelter
  validates_presence_of :status
end