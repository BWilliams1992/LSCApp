# frozen_string_literal: true

class AddLocationToInvoice < ActiveRecord::Migration[6.0]
  def change
    add_reference :invoices, :location, null: false, foreign_key: true
  end
end
