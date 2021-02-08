# frozen_string_literal: true

class RemoveCostFromHouse < ActiveRecord::Migration[6.0]
  def change
    remove_column :houses, :cost
  end
end
