class RemoveCurrentShelterColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :current_shelter
  end
end
