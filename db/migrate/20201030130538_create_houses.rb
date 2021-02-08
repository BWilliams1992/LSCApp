# frozen_string_literal: true

class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :sales_name
      t.float :cost
      t.string :build_number

      t.timestamps
    end
  end
end
