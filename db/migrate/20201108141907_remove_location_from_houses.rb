# frozen_string_literal: true

class RemoveLocationFromHouses < ActiveRecord::Migration[6.0]
  def change
    remove_reference :houses, :location, null: false, foreign_key: true
  end
end
