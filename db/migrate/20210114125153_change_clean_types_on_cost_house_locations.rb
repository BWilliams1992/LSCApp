class ChangeCleanTypesOnCostHouseLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :cost_house_locations, :pre_paint_cost, :float
    add_column :cost_house_locations, :post_paint_cost, :float
    remove_column :cost_house_locations, :build_cost
  end
end
