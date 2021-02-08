# frozen_string_literal: true

class AddStartDateToLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :start_date, :date
  end
end
