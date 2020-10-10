class RemoveStatusColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :status
  end
end
