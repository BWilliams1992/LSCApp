# frozen_string_literal: true

class AddSiteNameToLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :site_name, :string
  end
end
