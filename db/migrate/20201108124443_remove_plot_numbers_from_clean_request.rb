# frozen_string_literal: true

class RemovePlotNumbersFromCleanRequest < ActiveRecord::Migration[6.0]
  def change
    remove_column :clean_requests, :plot_numbers
    add_column :clean_requests, :plot_number, :string
  end
end
