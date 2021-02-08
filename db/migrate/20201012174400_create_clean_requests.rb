# frozen_string_literal: true

class CreateCleanRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :clean_requests, &:timestamps
  end
end
