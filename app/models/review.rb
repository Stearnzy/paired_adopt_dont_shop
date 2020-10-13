class Review < ApplicationRecord
  belongs_to :shelter, :user
  validates_presence_of :title, :rating, :content, :user_name
end