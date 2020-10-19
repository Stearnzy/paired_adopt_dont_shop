class User < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip
  has_many :applications
  has_many :reviews

  def review_average
    reviews.average(:rating)
  end

  def worst_review
    reviews.order(:rating).first
  end

  def best_review
    reviews.order(rating: :desc).first
  end
end