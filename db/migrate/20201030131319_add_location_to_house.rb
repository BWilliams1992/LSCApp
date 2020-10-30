class AddLocationToHouse < ActiveRecord::Migration[6.0]
  def change
    add_reference :houses, :location, null: false, foreign_key: true
  end
end
