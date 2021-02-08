# frozen_string_literal: true

class AddVoCostTolocation < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :vo_cost, :float
  end
end
