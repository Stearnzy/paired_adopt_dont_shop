class Review < ApplicationRecord
  belongs_to :shelter
  belongs_to :user
  validates_presence_of :title, :rating, :content
  # I think this is right..? We'll see...
  validates_presence_of :picture, allow_nil: true
end