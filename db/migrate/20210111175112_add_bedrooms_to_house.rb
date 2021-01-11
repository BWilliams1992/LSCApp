class AddBedroomsToHouse < ActiveRecord::Migration[6.0]
  def change
    add_column :houses, :bedrooms, :integer
  end
end
