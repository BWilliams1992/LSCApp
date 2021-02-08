# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices, &:timestamps
  end
end
