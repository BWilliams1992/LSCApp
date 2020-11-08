class AddHouseToPlot < ActiveRecord::Migration[6.0]
  def change
    add_reference :plots, :house, foreign_key: true
  end
end
