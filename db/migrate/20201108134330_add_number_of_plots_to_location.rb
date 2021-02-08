# frozen_string_literal: true

class AddNumberOfPlotsToLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :number_of_plots, :int
  end
end
