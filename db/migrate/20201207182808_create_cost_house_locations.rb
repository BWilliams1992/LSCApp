class CreateCostHouseLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :cost_house_locations do |t|
      t.integer :cost
      t.belongs_to :house
      t.belongs_to :location
      t.timestamps
    end
  end
end
