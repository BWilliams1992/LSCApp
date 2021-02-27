class AddDefaultApprovedToCleanRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :clean_requests, :approved
    add_column :clean_requests, :approved, :boolean, default: false
  end
end
