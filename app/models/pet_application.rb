class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  # validates_presence_of :approval
end