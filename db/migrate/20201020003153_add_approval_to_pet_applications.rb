class AddApprovalToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :approval, :boolean
  end
end
