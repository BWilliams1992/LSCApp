class AddDefaultHouseToLocation < ActiveRecord::Migration[6.0]
  def change
    add_reference :locations, :house, foreign_key: true
  end
end
