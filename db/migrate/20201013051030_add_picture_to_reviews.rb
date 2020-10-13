class AddPictureToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :picture, :string
  end
end
