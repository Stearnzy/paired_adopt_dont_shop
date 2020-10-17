class User < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip
  has_many :reviews

  def review_average
    reviews.average(:rating)
  end
end