# frozen_string_literal: true

class AddColumnsToCleanRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :clean_requests, :plot_numbers, :integer
    add_column :clean_requests, :clean, :string
    add_column :clean_requests, :notes, :text
    add_column :clean_requests, :approved, :boolean
    add_column :clean_requests, :date, :date
  end
end
