class House < ApplicationRecord
    has_many :cost_house_locations
    has_many :locations, :through => :cost_house_locations
end
