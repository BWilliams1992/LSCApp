# frozen_string_literal: true

class AddLocationToCleanRequest < ActiveRecord::Migration[6.0]
  def change
    add_reference :clean_requests, :location, foreign_key: true
  end
end
