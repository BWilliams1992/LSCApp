# frozen_string_literal: true

class RemoveCleanFromInvoice < ActiveRecord::Migration[6.0]
  def change
    remove_reference :cleans, :invoice
  end
end
