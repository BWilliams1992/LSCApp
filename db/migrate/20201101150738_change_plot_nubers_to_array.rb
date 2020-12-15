class ChangePlotNubersToArray < ActiveRecord::Migration[6.0]
  def change
    remove_column :clean_requests, :plot_numbers    
    add_column :clean_requests, :plot_numbers, :integer, array: true, default: []
  end
end
