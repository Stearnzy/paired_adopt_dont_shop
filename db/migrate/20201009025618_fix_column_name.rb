class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :pets, :shelter, :current_shelter
  end
end
