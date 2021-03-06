# frozen_string_literal: true

class CreatePlots < ActiveRecord::Migration[6.0]
  def change
    create_table :plots do |t|
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
