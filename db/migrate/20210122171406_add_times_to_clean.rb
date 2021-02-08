# frozen_string_literal: true

class AddTimesToClean < ActiveRecord::Migration[6.0]
  def change
    add_column :cleans, :start_time, :time
    add_column :cleans, :end_time, :time
  end
end
