# frozen_string_literal: true

class CostHouseLocation < ApplicationRecord
  belongs_to :house
  belongs_to :location
end
