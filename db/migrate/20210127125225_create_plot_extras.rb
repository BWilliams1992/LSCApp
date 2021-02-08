# frozen_string_literal: true

class CreatePlotExtras < ActiveRecord::Migration[6.0]
  def change
    create_table :plot_extras do |t|
      t.belongs_to :plot
      t.belongs_to :extra

      t.timestamps
    end
  end
end
