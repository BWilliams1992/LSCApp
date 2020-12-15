class CostHouseLocation < ApplicationRecord
  belongs_to :house
  belongs_to :location
end
