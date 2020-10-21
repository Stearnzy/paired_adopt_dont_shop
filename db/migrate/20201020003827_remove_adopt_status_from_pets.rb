class RemoveAdoptStatusFromPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :adopt_status
  end
end
