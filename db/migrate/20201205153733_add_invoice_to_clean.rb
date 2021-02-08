# frozen_string_literal: true

class AddInvoiceToClean < ActiveRecord::Migration[6.0]
  def change
    add_reference :cleans, :invoice, foreign_key: true
  end
end
