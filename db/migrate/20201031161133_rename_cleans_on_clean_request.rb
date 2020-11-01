class RenameCleansOnCleanRequest < ActiveRecord::Migration[6.0]
  def change
    rename_column :clean_requests, :clean, :clean_type
  end
end
