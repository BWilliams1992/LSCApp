# frozen_string_literal: true

class AddNumPeopleToClean < ActiveRecord::Migration[6.0]
  def change
    add_column :cleans, :num_people, :integer
  end
end
