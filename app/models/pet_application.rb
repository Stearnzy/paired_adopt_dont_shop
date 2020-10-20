class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates :approval, :inclusion => {:in => [true, false]}
end