class Hasmanythroughassocciationsupdate1 < ActiveRecord::Migration[6.0]
  def change
    add_reference :houses, :cost_house_locations, foreign_key: true
    add_reference :locations, :cost_house_locations, foreign_key: true
  end
end
