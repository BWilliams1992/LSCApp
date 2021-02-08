# frozen_string_literal: true

class AddCostsToCostHouseLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :cost_house_locations, :sparkle_cost, :float
    add_column :cost_house_locations, :build_cost, :float
    add_column :cost_house_locations, :demo_cost, :float
    remove_column :cost_house_locations, :cost
  end
end
