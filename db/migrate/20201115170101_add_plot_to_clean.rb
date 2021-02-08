# frozen_string_literal: true

class AddPlotToClean < ActiveRecord::Migration[6.0]
  def change
    remove_column :cleans, :plot
    add_reference :cleans, :plot, foreign_key: true
  end
end
