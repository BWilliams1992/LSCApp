# frozen_string_literal: true

class AddUserToCleanRequest < ActiveRecord::Migration[6.0]
  def change
    add_reference :clean_requests, :user, null: false, foreign_key: true
  end
end
